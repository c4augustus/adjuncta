#!/usr/bin/env python3
# convert COLLADA .dae exported from Xcode to importable by Urho3D
# [2018.04.23 c4augustus]

import argparse
import os
import re
import sys
from copy import deepcopy

# from https://stackoverflow.com/questions/1977362/how-to-create-module-wide-variables-in-python/35904211#35904211
this = sys.modules[__name__]

# from https://docs.python.org/3/tutorial/controlflow.html#defining-functions
def ask_ok(prompt, retries=4, reminder='Please try again!'):
    while True:
        ok = input(prompt)
        if ok in ('y', 'ye', 'yes'):
            return True
        if ok in ('n', 'no', 'nop', 'nope'):
            return False
        retries = retries - 1
        if retries < 0:
            raise ValueError('invalid user response')
        print(reminder)

# https://stackoverflow.com/questions/12332975/installing-python-module-within-code#15950647
def import_or_ask_to_install(package):
    import importlib
    try:
        globals()[package] = importlib.import_module(package)
    except ImportError:
        if not ask_ok("install package lxml? (y/n): "):
            return False
        import pip
        pip.main(['install', package])
        globals()[package] = importlib.import_module(package)
    return True

def parselxmltag(tag):
    # !!! lxml prefixes all tags with the schema
    m = re.search('^(\{.*\})?(.+)$', tag)
    tagschema = m.group(1) if m is not None else None
    tagtag = m.group(2) if m is not None else None
    return tagschema, tagtag

def removemeshverticesnormals(tagschema, elmesh):
    from lxml import etree
    elsvertices = elmesh.findall(tagschema + 'vertices')
    for elvertices in elsvertices:
        elinputs = elvertices.findall(tagschema + 'input')
        for elinput in elinputs:
            if elinput.get('semantic') == 'NORMAL':
                elvertices.remove(elinput)
                print('..removed <vertices> <input semantic="NORMAL">')

def fixmorphtriangles(tagschema, eloriginal, elmaster):
    from lxml import etree
    # TODO: @@@ IDEALLY COPY ALL ATTRIBUTES
    eloriginal.set('count', elmaster.get('count'))
    eloriginal.set('material', elmaster.get('material'))
    elinputs = elmaster.findall(tagschema + 'input')
    for elinput in elinputs:
        if elinput.get('semantic') == 'TEXCOORD':
            eloriginal.append(deepcopy(elinput))
            print('..added <triangles> texture coordinates')
    elp = elmaster.find(tagschema + 'p')
    if elp is not None:
        eloriginal.append(deepcopy(elp))
        print('..added <triangles> indices')

def fixgeometries(tagschema, elroot):
    elgeometries = elroot.find(tagschema + 'library_geometries')
    if elgeometries is None:
        print('..missing <library_geometries>')
        return
    eltrianglesfirst = None
    elsgeometry = elgeometries.findall(tagschema + 'geometry')
    for elgeometry in elsgeometry:
        elsmesh = elgeometry.findall(tagschema + 'mesh')
        for elmesh in elsmesh:
            removemeshverticesnormals(tagschema, elmesh)
            elstriangles = elmesh.findall(tagschema + 'triangles')
            for eltriangles in elstriangles:
                if eltrianglesfirst is None:
                    if eltriangles.get('count') is not '0':
                        eltrianglesfirst = eltriangles
                else:
                    if eltriangles.get('count') is '0':
                        fixmorphtriangles(tagschema, eltriangles,
                                          eltrianglesfirst)

def fixmorphnames(tagschema, elroot):
    elcontrollers = elroot.find(tagschema + 'library_controllers')
    if elcontrollers is None:
        print('..missing <library_controllers>')
        return
    elscontroller = elcontrollers.findall(tagschema + 'controller')
    for elcontroller in elscontroller:
        elsmorph = elcontroller.findall(tagschema + 'morph')
        for elmorph in elsmorph:
            elssource = elmorph.findall(tagschema + 'source')
            for elsource in elssource:
                elstechnique = elsource.findall(tagschema + 'technique_common')
                for eltechnique in elstechnique:
                    elsaccessor = eltechnique.findall(tagschema + 'accessor')
                    for elaccessor in elsaccessor:
                        elaccessor.set("count", "51")
                elsfloats = elsource.findall(tagschema + 'float_array')
                for elfloats in elsfloats:
                    elfloats.set("count", "51")
                elsidrefs = elsource.findall(tagschema + 'IDREF_array')
                for elidrefs in elsidrefs:
                    unsortedwords = elidrefs.text.split()
                    try:
                        unsortedwords.remove('inactive1')
                        print('..removed morph "inactive1"')
                    except:
                        pass
                    try:
                        unsortedwords.remove('inactive2')
                        print('..removed morph "inactive2"')
                    except:
                        pass
                    sortedwords = " ".join(sorted(unsortedwords))
                    elidrefs.text = sortedwords
                    elidrefs.set("count", "51")
                    print('..sorted morph names: ' + sortedwords)

def fixmaterialnames(tagschema, elroot):
    elmaterials = elroot.find(tagschema + 'library_materials')
    if elmaterials is None:
        print('..missing <library_materials>')
        return
    elsmaterial = elmaterials.findall(tagschema + 'material')
    for elmaterial in elsmaterial:
        name = elmaterial.get('name')
        if not name.startswith(this.filenamebase):
            newname = this.filenamebase + '_' + name
            elmaterial.set('name', newname)
            print('..changed material name from "'
                + name + '" to "' + newname + '"')

def fixnodeids(tagschema, elroot):
    elvisualscenes = elroot.find(tagschema + 'library_visual_scenes')
    if elvisualscenes is None:
        print('..missing <library_materials>')
        return
    elsvisualscene = elvisualscenes.findall(tagschema + 'visual_scene')
    for elvisualscene in elsvisualscene:
        elsnodeouter = elvisualscene.findall(tagschema + 'node')
        for elnodeouter in elsnodeouter:
            elsnodeinner = elnodeouter.findall(tagschema + 'node')
            for elnodeinner in elsnodeinner:
                nodeid = elnodeinner.get('id')
                if not nodeid.startswith(this.filenamebase):
                    newnodeid = this.filenamebase + nodeid
                    elnodeinner.set('id', newnodeid)
                    print('..changed node id from "'
                        + nodeid + '" to "' + newnodeid + '"')

def convertxmldoc(xmldoc):
    from lxml import etree
    elroot = xmldoc.getroot()
    tagschema, tagtag = parselxmltag(elroot.tag)
    if tagtag is 'COLLADA':
        print('..missing <COLLADA>')
        print(elroot.tag)
        return
    fixgeometries(tagschema, elroot)
    fixmorphnames(tagschema, elroot)
    fixmaterialnames(tagschema, elroot)
    fixnodeids(tagschema, elroot)

def convertfile(filepath):
    from lxml import etree
    try:
        xmldoc = etree.parse(filepath)
    except IOError:
        print('Failed to open input file "' + filepath + '"')
        return
    try:
        filepathbase, filepathext = os.path.splitext(filepath)
        this.filenamebase = os.path.basename(filepathbase)
        outfilepath = filepathbase + '-urho' + filepathext
        outfile = open(outfilepath, 'wb')
    except IOError:
        print('Failed to open out file "' + outfilepath + '"')
        return
    print("Converting file: " + filepath + "..")
    convertxmldoc(xmldoc)
    print("...Writing file: " + outfilepath)
    xmldoc.write(outfile, encoding='utf-8', xml_declaration=True)
    outfile.close()

def main():
    parser = argparse.ArgumentParser(
        description='convert COLLADA (.dae) file(s) exported from Xcode to be compatible for import into Urho3D',
    )
    parser.add_argument(
        'filepaths',
        metavar='filepath',
        nargs='+',
        help='input XML file(s)',
    )
    args = parser.parse_args()
    if not import_or_ask_to_install('lxml'):
        return
    for filepath in args.filepaths:
        convertfile(filepath)

if __name__ == '__main__':
    main()
