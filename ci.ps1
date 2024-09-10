Param(
    [string]$CreateTag
)

if ($CreateTag) {
    $Suffix = Get-Date -Format "yyyyMMdd-HHmm"
    $Tag = "$CreateTag-$Suffix"
    git tag -m "$Tag" "$Tag"
    git push --tags origin main:main
}