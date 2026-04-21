# LibVLC.AutoGen

[![NuGet Version](https://img.shields.io/nuget/v/LibVLC.AutoGen.svg)](https://www.nuget.org/packages/LibVLC.AutoGen/)
[![NuGet Downloads](https://img.shields.io/nuget/dt/LibVLC.AutoGen.svg)](https://www.nuget.org/packages/LibVLC.AutoGen/)

 **!!!!! This is NOT an official libVLC project !!!!!**
 
 P/Invoke bindings auto-generated from libvlc headers using ClangSharpPInvokeGenerator and Custom Source Generator.

# Quick start

 ```cmd
 dotnet add package LibVLC.AutoGen
 ```

```charp
using LibVLCSharp.AutoGen;
using static LibVLCSharp.AutoGen.Interop.libvlc;
using static LibVLCSharp.AutoGen.LibVLC;

internal class Program
{
    static unsafe void Main(string[] args)
    {
        var psz_version = (IntPtr)libvlc_get_version(); // LibVLCSharp.AutoGen.Interop, snake_case
        var version1 = psz_version.GetString(); // to utf8 string
        var version2 = VlcGetVersion(); // LibVLCSharp.AutoGen, PascalCase 
    }
}
```

# List
- `LibVLC.AutoGen` is a standard wrapper using `[DllImport("libvlc")]`.
- `LibVLC.AutoGen.Static` using `[DllImport("__Internal")]` for static linked libvlc.
- `LibVLC.AutoGen.Dynamic` for runtime loaded libvlc, requires manual `Initialize`.      


# Notes

- no `libvlc_printerr`, C# has poor compatibility with C variadic arguments.     
- no `libvlc_role_Last`, It is equivalent to `libvlc_role_Test`.     

# What it does?
**Via GitHub Action: pull the latest `VLC` code daily at midnight.**        
- Check if there are any updates in the `vlc/include/vlc` directory.       
- If updates are detected, automatically bump the version number of the current project, create a Git tag, and push it to the remote repository.

**Pushing a tag will trigger an automated build process:**             
- Execute generate.ps1, which uses `ClangSharpPInvokeGenerator` with the configuration file "@generate.rsp" to automatically generate `LibVLC.Interop.cs`.            
- When building the **LibVLC.AutoGen** project, **LibVLC.SourceGenerator** runs during the pre-compilation phase to auto-generate a renamed version: `LibVLC.Interop.g.cs`, based on `LibVLC.Interop.cs`.                   
- When building the **LibVLC.AutoGen.Dynamic/Static** projects, **LazyImport.Fody** is additionally integrated to modify the assemblies post-compilation, converting methods marked with DllImport into runtime-loaded implementations.                  

**The final compiled assemblies contain two namespaces:**    
- `LibVLC.Interop.cs` uses the `LibVLCSharp.AutoGen.Interop` namespace and follows the snake_case naming convention consistent with the C header files, similar to the `FFmpeg.AutoGen` project, enabling direct usage of the libvlc C code.             
- `LibVLC.Interop.g.cs` uses the `LibVLCSharp.AutoGen` namespace and follows C#'s default PascalCase naming convention, similar to the `LibVLCSharp` project.


# Why this project?
This project started because I needed to use libvlc_video_set_output_callbacks, the new video rendering API from LibVLC 4.0.0.     
I believe it provides a cleaner solution to airspace issues in WPF and other UI frameworks.    
While [LibVLCSharp](https://github.com/videolan/libvlcsharp)  is very well-designed, the v4 prerelease is not yet officially stable, and its interop layer is not fully automated.     
For that reason, I created this fresh project:     
It uses GitHub Actions + ClangSharpPInvokeGenerator + Custom Source Generator to automatically generate up-to-date P/Invoke bindings for VLC.

Feedback and contributions are welcome!    



# TODO
Create a new VLC media control using the video rendering API `libvlc_video_set_output_callbacks`.


# Reference & Thanks

- [vlc](https://github.com/videolan/vlc)

- [LibVLCSharp](https://github.com/videolan/libvlcsharp) 

- [ClangSharp](https://github.com/dotnet/ClangSharp)

# License
 
 This project is licensed under the MIT License.      
 But the LibVLC is licensed under the GNU LGPLv2.1 License, use and distribution must comply with the LGPL.
Last updated: 2026-04-21 01:55:10Z
