-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local Foundation = require(GenericAbuseReportingParent.Foundation)
local React = require(GenericAbuseReportingParent.React)
local translate = require(script.Parent.translate)

local FFlagAbuseReportTranslateColorWrapper = require(GenericAbuseReporting.Flags.FFlagAbuseReportTranslateColorWrapper)

local useTokens = Foundation.Hooks.useTokens

local translateIntoString = translate.translateIntoString
local translateIntoRichTextString = translate.translateIntoRichTextString

local ArTranslationContext = React.createContext(nil)

return {
    ArTranslationContext = ArTranslationContext,
    ArTranslationProvider = function(tbl1)
        local var1 = if FFlagAbuseReportTranslateColorWrapper then useTokens() else nil
        local var2 = if FFlagAbuseReportTranslateColorWrapper then `#{var1.Color.Content.Link.Color3:ToHex()}` else nil

        local value = React.useMemo(function()
            return {
                translateIntoString = function(arg1)
                    return translateIntoString(tbl1.translations, arg1)
                end,
                translateIntoRichTextString = function(arg1, bool1: boolean?)
                    return translateIntoRichTextString(tbl1.translations, arg1, var2, bool1)
                end
            }
        end, { tbl1.translations, var2 })

        return React.createElement(ArTranslationContext.Provider, { value = value }, tbl1.children)
    end,
    useArTranslation = function()
        local var1 = React.useContext(ArTranslationContext)

        if not var1 then
            error(
                "Invalid use of `useArTranslation` hook. Ensure your component has an ancestor wrapped in `ArTranslationProvider`"
            )
        end

        return var1
    end
}
