@echo off
set build_type=%1
set platform=%2
set source_dir=%~dp0
set build_dir=%source_dir%build\%platform%

git clone -q https://github.com/microsoft/vcpkg %source_dir%\vcpkg
call %source_dir%\vcpkg\bootstrap-vcpkg.bat
%source_dir%\vcpkg\vcpkg.exe install libssh:x64-windows-static
%source_dir%\vcpkg\vcpkg.exe install libssh:x86-windows-static
