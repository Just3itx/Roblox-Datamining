-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local OnPlatformSurveys = script:FindFirstAncestor("OnPlatformSurveys")
local OnPlatformSurveysParent = OnPlatformSurveys.Parent

local Foundation = require(OnPlatformSurveysParent.Foundation)
local React = require(OnPlatformSurveysParent.React)

local View = Foundation.View

local Surface = require(OnPlatformSurveys.Enums.Surface)
local SurveyModal = require(OnPlatformSurveys.Components.SurveyModal)

return React.memo(function(tbl1) -- name: SurfaceWrapper
    if tbl1.surface ~= Surface.Modal then
        return React.createElement(View, { tag = "size-full-0 auto-y" }, tbl1.children)
    end

    return React.createElement(
        SurveyModal,
        {
            isOpen = tbl1.isOpen,
            onClose = tbl1.onClose,
            title = tbl1.title,
            footer = tbl1.footer,
            children = tbl1.children
        }
    )
end)
