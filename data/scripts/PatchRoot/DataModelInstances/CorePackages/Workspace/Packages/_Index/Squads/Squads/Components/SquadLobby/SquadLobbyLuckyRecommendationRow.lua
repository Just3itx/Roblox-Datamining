-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local FFlagSquadsEnableFoundationTestIds = require(Squads.Flags.FFlagSquadsEnableFoundationTestIds)

local dependencies = require(Squads.dependencies)
local React = dependencies.React
local Foundation = dependencies.Foundation
local useEffectOnce = dependencies.Hooks.useEffectOnce
local useLocalization = dependencies.Hooks.useLocalization

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconSize = Foundation.Enums.IconSize
local useTokens = Foundation.Hooks.useTokens

local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local useCurrentSquadMembers = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadMembers
local EventNames = require(SquadsParent.SquadsCore.EventNames)

local SquadLobbyLuckyRecommendationModal = require(script.Parent.SquadLobbyLuckyRecommendationModal)

local function SquadLobbyLuckyRecommendationRow(_)
    local var1 = useTokens()
    local var2, var3 = React.useState(false)
    local var4 = useLocalization(
        {
            title = "Feature.Squads.Label.LuckyRecommendationRow",
            body = "Feature.Squads.Description.LuckyRecommendationRow"
        }
    )

    local localUserId = tonumber(useLocalUserId()) or 0
    local var5 = React.useContext(SquadExternalContractContext)
    local current = useCurrentSquadMembers()
    local var7 = React.useRef(current)
    var7.current = current

    local var8 = React.useRef("")

    useEffectOnce(function()
        var5.fireSquadAnalytics(
            EventNames.LuckyRecommendationRowImpression,
            {
                localUserId = localUserId,
                clientTimestamp = os.time()
            }
        )
    end, true)

    local onActivated = React.useCallback(function()
        local str1 = HttpService:GenerateGUID(false)
        var8.current = str1
        local current = var7.current
        var5.fireSquadAnalytics(EventNames.LuckyRecommendationInvoked, {
            luckyRecommendationSessionId = str1,
            localUserId = localUserId,
            squadMemberCount = current and #current or 0,
            clientTimestamp = os.time()
        })
        var3(true)
    end, { localUserId, var5 })

    local onClose = React.useCallback(function()
        var3(false)
    end, {})

    return React.createElement(React.Fragment, nil, {
        Row = React.createElement(View, { tag = "size-full-0 auto-y padding-x-xlarge" }, {
            Card = React.createElement(View, {
                tag = "row align-y-center gap-medium size-full-0 auto-y stroke-standard stroke-position-inner stroke-default radius-medium bg-surface-0 gui-object-defaults",
                padding = {
                    left = UDim.new(0, var1.Padding.XLarge),
                    right = UDim.new(0, var1.Padding.Medium),
                    top = UDim.new(0, var1.Padding.Large),
                    bottom = UDim.new(0, var1.Padding.Large)
                },
                onActivated = onActivated,
                testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-lucky-recommendation-row" else nil
            }, {
                Content = React.createElement(View, {
                    tag = "col fill gap-xsmall auto-y",
                    LayoutOrder = 1
                }, {
                    Title = React.createElement(FoundationText, {
                        tag = "size-full-0 auto-y text-title-medium text-no-wrap text-align-x-left text-truncate-end content-emphasis",
                        LayoutOrder = 1,
                        Text = var4.title,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-lucky-recommendation-row--title" else nil
                    }),
                    Body = React.createElement(FoundationText, {
                        tag = "size-full-0 auto-y text-body-medium text-no-wrap text-align-x-left text-truncate-end content-default",
                        LayoutOrder = 2,
                        Text = var4.body,
                        testId = if FFlagSquadsEnableFoundationTestIds then "--social-squad-lobby-lucky-recommendation-row--body" else nil
                    })
                }),
                Chevron = React.createElement(Icon, { LayoutOrder = 2, name = "chevron-large-right", size = IconSize.Small })
            })
        }),
        Modal = if var2 then React.createElement(SquadLobbyLuckyRecommendationModal, { onClose = onClose, sessionId = var8.current }) else nil
    })
end

return SquadLobbyLuckyRecommendationRow
