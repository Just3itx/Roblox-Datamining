-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local success, result = pcall(function()
    return require(CorePackages.Workspace.Packages.DataModelStreaming)
end)

if not success or type(result) ~= "table" then
    return
end

local initDataModelStreamWsClient = result.initDataModelStreamWsClient
if type(initDataModelStreamWsClient) ~= "function" then
    return
end

initDataModelStreamWsClient("experience")
