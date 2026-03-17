using System;

namespace LibVLC.AutoGen
{ 
    [AttributeUsage(AttributeTargets.All, Inherited = false)]
    public sealed class NativeTypeNameAttribute : Attribute
    {
        public NativeTypeNameAttribute(string name)
        {
            Name = name;
        }

        public string Name { get; }
    }
}
