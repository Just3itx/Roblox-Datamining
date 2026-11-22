-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local HttpService = game:GetService("HttpService")

return require(ProgressLoadingParent.Http).NetworkLayers.requestInternalWrapper(HttpService)
