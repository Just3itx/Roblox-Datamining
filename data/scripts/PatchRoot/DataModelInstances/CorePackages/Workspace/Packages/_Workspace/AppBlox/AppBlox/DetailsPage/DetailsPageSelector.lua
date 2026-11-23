-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppBloxParent = script:FindFirstAncestor("AppBlox").Parent
local DetailsPageTemplate = require(script.Parent.DetailsPageTemplate)
local DetailsPageTenfootTemplate = require(script.Parent.DetailsPageTenfootTemplate)

local DeviceType = require(AppBloxParent.RobloxAppEnums).DeviceType

local React = require(AppBloxParent.React)

local tbl1 = {
    [DeviceType.Console] = DetailsPageTenfootTemplate,
    [DeviceType.Phone] = DetailsPageTemplate,
    [DeviceType.Desktop] = DetailsPageTemplate,
    [DeviceType.Unknown] = DetailsPageTemplate,
    [DeviceType.Tablet] = DetailsPageTemplate,
    [DeviceType.VR] = DetailsPageTemplate
}

local function DetailsPageTemplateSelector(tbl2)
    local var1 = tbl1[tbl2.deviceType] or DetailsPageTemplate
    return React.createElement(var1, tbl2.detailsPageProps)
end

return DetailsPageTemplateSelector
