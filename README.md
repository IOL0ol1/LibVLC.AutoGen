# LibVLC.AutoGen

[![NuGet Version](https://img.shields.io/nuget/v/LibVLC.AutoGen.svg)](https://www.nuget.org/packages/LibVLC.AutoGen/)
[![NuGet Downloads](https://img.shields.io/nuget/dt/LibVLC.AutoGen.svg)](https://www.nuget.org/packages/LibVLC.AutoGen/)

 P/Invoke bindings auto-generated from libvlc headers using ClangSharpPInvokeGenerator.

# Why this project?
This project started because I needed to use libvlc_video_set_output_callbacks, the video rendering API from LibVLC 4.0.0.     
I believe it provides a cleaner solution to airspace issues in WPF and other UI frameworks.    
While LibVLCSharp is very well-designed, the v4 prerelease is not yet officially stable, and its interop layer is not fully automated.     
For that reason, I created this fresh project:     
It uses GitHub Actions and ClangSharpPInvokeGenerator to automatically generate up-to-date P/Invoke bindings for VLC.

Feedback and contributions are welcome!    


# List
- `LibVLC.AutoGen` is a standard wrapper using `[DllImport("libvlc")]`.
- `LibVLC.AutoGen.Static` using `[DllImport("__Internal")]` for static linked libvlc.
- `LibVLC.AutoGen.Dynamic` for runtime loaded libvlc.    

Their usage is identical.      
Only `LibVLC.AutoGen.Dynamic` requires manual initialization.    
`libvlc.initialize(string dllPath)` or `libvlc.initialize(IntPtr dllHandle)`    


# Notes

- no `libvlc_printerr`, C# has poor compatibility with C variadic arguments.     
- no `libvlc_role_Last`, it's a macro definition for `libvlc_role_Test`.     
    You can use `libvlc_media_player_role_t.libvlc_role_Test` instead.

# TODO
Create a new VLC media control using the video rendering API `libvlc_video_set_output_callbacks`.


# Reference & Thanks

- [vlc](https://github.com/videolan/vlc)

- [LibVLCSharp](https://github.com/videolan/libvlcsharp) 

- [FFmpeg.AutoGen](https://github.com/Ruslan-B/FFmpeg.AutoGen) 

# License
 
 This project is licensed under the MIT License.      
 The LibVLC is licensed under the GNU LGPLv2.1 License, use and distribution must comply with the LGPL.