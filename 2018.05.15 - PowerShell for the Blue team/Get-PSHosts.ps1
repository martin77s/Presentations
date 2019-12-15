param($Path = $pwd.Path)
dir $Path -Recurse -Include '*.exe', '*.dll' -ea 0 -pv file | % {
    try {
        $asm = [Reflection.Assembly]::ReflectionOnlyLoadFrom($_.FullName)
        if ($asm.GetReferencedAssemblies().Name -contains 'System.Management.Automation') {
            $_.FullName
        }
    } catch {}
}
