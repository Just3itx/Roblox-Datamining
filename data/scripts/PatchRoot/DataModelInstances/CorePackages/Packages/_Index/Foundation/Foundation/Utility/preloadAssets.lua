-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:09Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local Flags = require(Foundation.Utility.Flags)
local FoundationCloudAssets = require(FoundationParent.FoundationCloudAssets)
local devAssert = require(Foundation.Utility.devAssert)
local Assets = FoundationCloudAssets.Assets
local preloadAsset = FoundationCloudAssets.preloadAsset

return function(arg1)
    arg1 = typeof(arg1) == "string" and { arg1 } or arg1

    Dash.forEach(arg1, function(arg2)
        local str1 = `preloadAssets should only be used with valid FoundationCloudAssets; {arg2} is an invalid name`
        if Flags.FoundationDevOnlyPropAsserts then
            devAssert(Assets[arg2], str1)
            if not Assets[arg2] then
                return
            end
        else
            assert(Assets[arg2], str1)
        end
        preloadAsset(arg2)
    end)
end
