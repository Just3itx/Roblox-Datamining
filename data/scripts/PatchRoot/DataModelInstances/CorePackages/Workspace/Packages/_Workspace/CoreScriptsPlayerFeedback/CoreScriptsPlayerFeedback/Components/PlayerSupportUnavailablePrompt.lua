-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local CoreScriptsPlayerFeedbackParent = CoreScriptsPlayerFeedback.Parent

local React = require(CoreScriptsPlayerFeedbackParent.React)

local Foundation = require(CoreScriptsPlayerFeedbackParent.Foundation)
local Dialog = Foundation.Dialog
local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local useTokens = Foundation.Hooks.useTokens

local BuilderIcons = require(CoreScriptsPlayerFeedbackParent.BuilderIcons)
local IconVariant = BuilderIcons.IconVariant

local useLocalization = require(CoreScriptsPlayerFeedbackParent.Localization).Hooks.useLocalization

local useEscapeDismiss = require(CoreScriptsPlayerFeedback.Hooks.useEscapeDismiss)
local FFlagPlayerSupportPromptEventIngest = require(CoreScriptsPlayerFeedback.Flags.FFlagPlayerSupportPromptEventIngest)
local PlayerSupportPromptTelemetry = require(CoreScriptsPlayerFeedback.Telemetry.PlayerSupportPromptTelemetry)

local tbl1 = {
    TICKET_CREATION_TEXT_FILTER_ERROR = {
        titleKey = "TextFilterTitle",
        bodyKey = "TextFilterBody",
        hasReportLink = true
    },
    TICKET_CREATION_GIBBERISH_ERROR = { titleKey = "TextFilterTitle", bodyKey = "GibberishBody" },
    TICKET_CREATION_ELIGIBILITY_FAILURE_REASON_UNDER13 = {
        titleKey = "Under13Title",
        bodyKey = "Under13Body"
    },
    TICKET_CREATION_ELIGIBILITY_FAILURE_REASON_NOT_RECENTLY_VISITED = {
        titleKey = "NotRecentlyVisitedTitle",
        bodyKey = "NotRecentlyVisitedBody"
    },
    TICKET_CREATION_ELIGIBILITY_FAILURE_REASON_OPEN_TICKET_LIMIT_REACHED = {
        titleKey = "OpenTicketLimitTitle",
        bodyKey = "OpenTicketLimitBody"
    },
    RateLimited = { titleKey = "RateLimitedTitle", bodyKey = "RateLimitedBody" }
}

local tbl2 = { titleKey = "DefaultTitle", bodyKey = "DefaultBody" }

local function openAbuseReportPage() -- Luacid: Inlined by compiler; 1 call site recovered
    pcall(function()
        local robloxGui = game:GetService("CoreGui"):FindFirstChild("RobloxGui")
        local modules = robloxGui and robloxGui:FindFirstChild("Modules") or nil
        local settings = modules and modules:FindFirstChild("Settings") or nil
        local settingsHub = settings and settings:FindFirstChild("SettingsHub") or nil
        if not settingsHub then
            return
        end
        local var1 = require(settingsHub)
        var1:SetVisibility(true, false, var1.Instance.ReportAbusePage)
    end)
end

return (React.memo(function(tbl3)
    local var1 = useTokens()

    local var2 = useLocalization({
        BackButton = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.BackButton",
        Under13Title = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.Under13.Title",
        Under13Body = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.Under13.Body",
        NotRecentlyVisitedTitle = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.NotRecentlyVisited.Title",
        NotRecentlyVisitedBody = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.NotRecentlyVisited.Body",
        OpenTicketLimitTitle = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.OpenTicketLimit.Title",
        OpenTicketLimitBody = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.OpenTicketLimit.Body",
        RateLimitedTitle = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.RateLimited.Title",
        RateLimitedBody = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.RateLimited.Body",
        DefaultTitle = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.Default.Title",
        DefaultBody = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.Default.Body",
        TextFilterTitle = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.TextFilter.Title",
        TextFilterBody = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.TextFilter.Body",
        GibberishBody = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.Unavailable.Gibberish.Body",
        TextFilterLink = "CoreScripts.FeedbackPrompt.PlayerSupportPrompt.ReportAbuse.Link"
    })

    local var3 = tbl1[tbl3.reason or ""] or tbl2
    local tbl4 = {
        title = var2[var3.titleKey],
        body = var2[var3.bodyKey],
        hasReportLink = var3.hasReportLink
    }

    local reason = tbl3.reason or ""

    if FFlagPlayerSupportPromptEventIngest then
        React.useEffect(function()
            PlayerSupportPromptTelemetry.logUnavailableShown(reason)
        end, { reason })
    end

    local onActivated = React.useCallback(function()
        if FFlagPlayerSupportPromptEventIngest and tbl3.openPlayerSupportPrompt then
            PlayerSupportPromptTelemetry.log({ action = PlayerSupportPromptTelemetry.Action.RejectionRetry, reason = reason })
        end

        tbl3.closePrompt()
        if tbl3.openPlayerSupportPrompt then
            tbl3.openPlayerSupportPrompt()
        end
    end, FFlagPlayerSupportPromptEventIngest and { tbl3.closePrompt, tbl3.openPlayerSupportPrompt, reason }
        or { tbl3.closePrompt, tbl3.openPlayerSupportPrompt })

    local var4 = React.useCallback(function()
        if FFlagPlayerSupportPromptEventIngest then
            PlayerSupportPromptTelemetry.log({ action = PlayerSupportPromptTelemetry.Action.ReportAbuseClicked, reason = reason })
        end

        tbl3.closePrompt()
        openAbuseReportPage()
    end, FFlagPlayerSupportPromptEventIngest and { tbl3.closePrompt, reason } or { tbl3.closePrompt })

    useEscapeDismiss("PlayerSupportUnavailableCancel", onActivated)

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl5 = { hasBackdrop = true }

    local tbl6 = { Content = 0, Actions = 0 }
    local createElement2 = React.createElement
    local content = Dialog.Content
    local tbl7 = { LayoutOrder = 1 }

    local tbl8 = {
        Body = React.createElement(
            View,
            {
                tag = "col gap-large size-full-0 auto-y",
                padding = {
                    top = UDim.new(0, var1.Size.Size_500)
                }
            },
            {
                TitleRow = React.createElement(View, {
                    tag = "row items-center gap-small auto-y",
                    LayoutOrder = 1
                }, {
                    AlertIcon = React.createElement(Icon, {
                        name = BuilderIcons.Icon.TriangleExclamation,
                        size = IconSize.Large,
                        variant = IconVariant.Filled,
                        style = var1.Color.System.Alert,
                        LayoutOrder = 1
                    }),
                    TitleText = React.createElement(FoundationText, {
                        Text = tbl4.title,
                        tag = "auto-xy text-heading-small text-align-x-left",
                        TextYAlignment = Enum.TextYAlignment.Center,
                        textStyle = var1.Color.Content.Emphasis,
                        LayoutOrder = 2
                    })
                }),
                Paragraph = React.createElement(FoundationText, {
                    Text = tbl4.body,
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left",
                    textStyle = var1.Color.Content.Default,
                    LayoutOrder = 2
                }),
                LinkRow = if tbl4.hasReportLink then React.createElement(FoundationText, {
                    Text = var2.TextFilterLink,
                    RichText = true,
                    onActivated = var4,
                    selection = { Selectable = true },
                    tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left",
                    textStyle = var1.Color.Content.Default,
                    LayoutOrder = 3
                }) else nil
            }
        )
    }
    tbl6.Content = createElement2(content, tbl7, tbl8)

    tbl6.Actions = React.createElement(Dialog.Actions, {
        LayoutOrder = 2,
        actions = {{
            text = var2.BackButton,
            variant = ButtonVariant.Emphasis,
            onActivated = onActivated
        }}
    })
    return createElement(root, tbl5, tbl6)
end))
