-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:50:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local ProgressTile = require(script.Parent.ProgressTile)
local useLocalization = require(AmpUpsellParent.Localization).Hooks.useLocalization
local IDVStep = require(AmpUpsell.Common.Enums).IDVStep

local function ProgressChecklist(tbl1)
    local var1 = useLocalization({
        connectedMobile = "Verification.Identity.Label.ConnectingToMobile",
        verifyingYou = "Verification.Identity.Label.VerifyingYou",
        waitingForResults = "Verification.Identity.Label.VerificationWaitingForResults",
        updatingRbxProfile = "Verification.Identity.Label.UpdatingRoblox"
    })

    local finished = tbl1.latestStepCompleted >= IDVStep.ConnectedMobile
    local bool1 = tbl1.latestStepCompleted >= IDVStep.Verified
    local bool2 = tbl1.latestStepCompleted >= IDVStep.GotResults
    local bool3 = tbl1.latestStepCompleted >= IDVStep.UpdatedRobloxProfile

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, tbl1.entryHeight * 4),
            BackgroundTransparency = 1,
            LayoutOrder = tbl1.layoutOrder
        },
        {
            UIListLayout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }),
            MobileCheck = React.createElement(
                ProgressTile,
                {
                    frameHeight = tbl1.entryHeight,
                    layoutOrder = 1,
                    finished = finished,
                    progressText = var1.connectedMobile
                }
            ),
            VerifiedCheck = React.createElement(
                ProgressTile,
                {
                    frameHeight = tbl1.entryHeight,
                    layoutOrder = 2,
                    finished = bool1,
                    progressText = var1.verifyingYou
                }
            ),
            GotResultsCheck = React.createElement(
                ProgressTile,
                {
                    frameHeight = tbl1.entryHeight,
                    layoutOrder = 3,
                    finished = bool2,
                    progressText = var1.waitingForResults
                }
            ),
            UpdateProfileCheck = React.createElement(
                ProgressTile,
                {
                    frameHeight = tbl1.entryHeight,
                    layoutOrder = 4,
                    finished = bool3,
                    progressText = var1.updatingRbxProfile
                }
            )
        }
    )
end

return ProgressChecklist
