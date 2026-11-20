-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T12:30:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local tbl1 = {
    NoFlags = 0,
    PerformedWork = 1,
    Placement = 2,
    Update = 4,
    PlacementAndUpdate = 6,
    Deletion = 8,
    ContentReset = 16,
    Callback = 32,
    DidCapture = 64,
    Ref = 128,
    Snapshot = 256,
    Passive = 512,
    PassiveUnmountPendingDev = 8192,
    Hydrating = 1024,
    HydratingAndUpdate = 1028,
    HostUpdate = 262144,
    LifecycleEffectMask = 932,
    HostEffectMask = 2047,
    Incomplete = 2048,
    ShouldCapture = 4096,
    ForceUpdateForLegacySuspense = 16384,
    PassiveStatic = 32768
}

if require(script.Parent.Parent.Shared).ReactFeatureFlags.enableCommitTraversalTrims then
    tbl1.BeforeMutationMask = 266
    tbl1.MutationMask = 263326
else
    tbl1.BeforeMutationMask = 778
    tbl1.MutationMask = 1182
end
tbl1.LayoutMask = 164
tbl1.PassiveMask = 520

tbl1.StaticMask = 32768

tbl1.MountLayoutDev = 65536
tbl1.MountPassiveDev = 131072

return tbl1
