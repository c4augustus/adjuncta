rem Build minimal Racket without packages as Windows executables.
rem This script must be executed from the top of the repo tree.
rem
rem Note that build-racket needs to be executed first under WSL
rem so that the Chez Scheme and Racket boot files get built.
rem
rem NOTE that main.zuo invokes git remote calls many times,
rem thus an internet connection is required during build--
rem WHICH IS HIGHLY UNDESIREABLE--unless we modify main.zuo.
rem
cd racket\src\worksp
call msvcprep x86_amd64
cd ..
call winfig
nmake
cd ..\..
