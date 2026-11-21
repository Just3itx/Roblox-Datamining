-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditor = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor")
local AvatarExperienceProfilePictureEditorParent = AvatarExperienceProfilePictureEditor.Parent

local Http = require(AvatarExperienceProfilePictureEditorParent.Http)
local HttpService = game:GetService("HttpService")
local Promise = require(AvatarExperienceProfilePictureEditorParent.Promise)
local AvatarExperienceCatalog = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceCatalog)

local Enums = require(AvatarExperienceProfilePictureEditor.Common.Enums)

local getWidgetListInfo = AvatarExperienceCatalog.Api.getWidgetListInfo

local function buildHydrateUrl(): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{Http.Url.APIS_URL}marketplace-widgets/v1/widgets/hydrate`
end

local function extractWidgetContent(arg1)
    local result = {}
    if arg1 == nil then
        return result
    end

    local widgets = arg1.widgets
    if widgets == nil then
        return result
    end

    for _, widget in pairs(widgets) do
        local content = widget.content
        if content == nil then
            continue
        end

        for _, value in content do
            table.insert(result, { type = value.type, id = value.id })
        end
    end

    return result
end

local function hydrateWidgetContent(func1: (...any) -> (...any), content)
    if #content == 0 then
        return nil
    end

    local postBody = HttpService:JSONEncode({ Content = content })

    return func1(buildHydrateUrl(), Enums.RequestMethods.POST, { postBody = postBody }):andThen(function(arg1)
        return arg1.responseBody
    end)
end

local function processWidgetsResponseAndHydrate(func1: (...any) -> (...any), widgetListInfo)
    local widgetContent = extractWidgetContent(widgetListInfo)

    if #widgetContent == 0 then
        return Promise.resolve({ widgetListInfo = widgetListInfo, hydrateResponseBody = nil, widgetContent = widgetContent })
    end

    return hydrateWidgetContent(func1, widgetContent):andThen(function(hydrateResponseBody)
        return {
            widgetListInfo = widgetListInfo,
            hydrateResponseBody = hydrateResponseBody,
            widgetContent = widgetContent
        }
    end)
end

local function toGetWidgetListInfoRequestImpl(func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(str1: string, str2: string)
        return func1(str1, str2)
    end
end

return {
    PROFILE_FRAMES_WIDGET_CONTEXT = "catalog-tab:profile-frames",
    buildHydrateUrl = buildHydrateUrl,
    extractWidgetContent = extractWidgetContent,
    fetchProfileFramesWidgets = function(func1: (...any) -> (...any), tbl1)
        local var1 = if tbl1 and tbl1.requestId then tbl1.requestId else HttpService:GenerateGUID(false)
        local func2 = toGetWidgetListInfoRequestImpl(func1)

        return getWidgetListInfo(func2, var1, "catalog-tab:profile-frames", nil):andThen(function(widgetListInfo)
            return processWidgetsResponseAndHydrate(func1, widgetListInfo)
        end)
    end
}
