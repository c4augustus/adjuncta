import bpy
op = bpy.context.active_operator

op.filepath = '/Users/admin/v/dev/content/silo/railer/spec/path/rail/_exported/nudger-a.dae'
op.apply_modifiers = True
op.export_mesh_type = 0
op.export_mesh_type_selection = 'view'
op.selected = True
op.include_children = False
op.include_armatures = False
op.include_shapekeys = True
op.deform_bones_only = False
op.active_uv_only = False
op.use_texture_copies = False
op.triangulate = True
op.use_object_instantiation = True
op.use_blender_profile = True
op.sort_by_name = False
op.export_transformation_type = 0
op.export_transformation_type_selection = 'matrix'
op.export_texture_type = 0
op.export_texture_type_selection = 'mat'
op.open_sim = False
op.limit_precision = False
op.keep_bind_info = False
