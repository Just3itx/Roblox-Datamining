-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)
local t = require(GenericAbuseReportingParent.t)

local FFlagAddThumbnailSelectorReport = SharedFlags.FFlagAddThumbnailSelectorReport

local tbl1 = {
    componentType = t.literal("dropdown"),
    isOptional = t.boolean,
    formDataKey = t.string,
    requirementMessage = t.string,
    dropdown = t.interface({
        prompt = t.string,
        placeholder = t.string,
        items = t.array(t.interface({ label = t.string, formDataValue = t.union(t.number, t.string) }))
    })
}

local tbl2 = {
    componentType = t.literal("freeComment"),
    isOptional = t.boolean,
    formDataKey = t.string,
    requirementMessage = t.string,
    freeComment = t.interface({ prompt = t.string, placeholder = t.string })
}

local tbl3 = {
    componentType = t.literal("paragraph"),
    isOptional = t.boolean,
    formDataKey = t.optional(t.string),
    paragraph = t.interface({
        text = t.string,
        links = t.optional(t.map(t.string, t.interface({ label = t.string, linkButtonLabel = t.string, url = t.string })))
    })
}

local tbl4 = {
    componentType = t.literal("selector"),
    isOptional = t.boolean,
    formDataKey = t.string,
    requirementMessage = t.string,
    selector = t.interface({ prompt = t.string })
}

local tbl5 = {
    componentType = t.literal("link"),
    isOptional = t.boolean,
    formDataKey = t.optional(t.string),
    link = t.interface({ label = t.string, linkButtonLabel = t.string, url = t.string })
}

local tbl6 = {
    type = t.literal("configurableComponentList"),
    configurableComponentList = 0
}
local interface = t.interface
local tbl7 = { components = 0 }
local var1

if FFlagAddThumbnailSelectorReport then
    var1 = t.array(t.union(t.interface(tbl1), t.interface(tbl2), t.interface(tbl3), t.interface(tbl4), t.interface(tbl5)))
else
    var1 = t.array(t.union(t.interface(tbl1), t.interface(tbl2), t.interface(tbl3), t.interface(tbl5)))
end

tbl7.components = var1
tbl6.configurableComponentList = interface(tbl7)

local var2 = t.union(t.interface(tbl6))

local tbl8 = {
    title = t.string,
    subtitle = t.string,
    actionInfo = t.interface(
        {
            actionLabel = t.optional(t.string),
            predefinedNextStepId = t.number,
            shouldSubmit = t.optional(t.boolean)
        }
    ),
    stepId = t.number,
    internalStepName = t.string,
    isCompletionStep = t.optional(t.boolean),
    innerContentConfig = t.optional(var2),
    footerContentConfig = t.optional(var2)
}

return {
    AbuseReportBeduiContextStatus = { Loading = "Loading", Success = "Success", Error = "Error" },
    BeduiDataTypeInterface = {
        rootStepId = t.number,
        nodes = t.array(t.interface(tbl8))
    },
    ComponentType = {
        Dropdown = "dropdown",
        FreeComment = "freeComment",
        Paragraph = "paragraph",
        Selector = if FFlagAddThumbnailSelectorReport then "selector" else nil,
        WebViewLink = "link"
    },
    ContentConfigType = {
        InnerContentConfig = "innerContentConfig",
        FooterContentConfig = "footerContentConfig"
    },
    InnerContentConfigType = { ConfigurableComponentList = "configurableComponentList" },
    NotificationType = { OpenCustomWebView = 20 }
}
