using System;
using System.Runtime.InteropServices;
using System.Text;

namespace LibVLCSharp.AutoGen
{
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter | AttributeTargets.ReturnValue, AllowMultiple = false, Inherited = true)]
    public sealed class NativeTypeNameAttribute : Attribute
    {
        public NativeTypeNameAttribute(string name)
        {
            Name = name;
        }

        public string Name { get; }
    }

    public static partial class StringExtensions
    {
        public unsafe static string GetString(this IntPtr pNativeData)
        {
            if (pNativeData == IntPtr.Zero)
                return null;
            int len = 0;
            while (Marshal.ReadByte(pNativeData, len) != 0) len++;
            return Encoding.UTF8.GetString((byte*)pNativeData, len);
        }
    }
}
