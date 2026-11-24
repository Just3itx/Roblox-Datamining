-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameInviteParent = script:FindFirstAncestor("GameInvite").Parent
local React = require(GameInviteParent.React)
local Foundation = require(GameInviteParent.Foundation)
local PartialPageModal = require(GameInviteParent.UIBlox).App.Dialog.Modal.PartialPageModal
local LocalizationService = game:GetService("LocalizationService")
local BrowserService = game:GetService("BrowserService")
local HttpService = game:GetService("HttpService")
local GetFStringReferralRewardsTermsURL = require(GameInviteParent.SharedFlags).GetFStringReferralRewardsTermsURL
local bool1 = game:DefineFastFlag("EnableRewardsWebViewOverlay", false)

local function func1(): Vector2 -- Luacid: Inlined by compiler; 1 call site recovered
    return workspace.CurrentCamera.ViewportSize
end

local function func2(expiryUtc: string): string
    if not expiryUtc or expiryUtc == "" then
        return ""
    end
    local isoDate = DateTime and DateTime.fromIsoDate(expiryUtc) or nil
    if not isoDate then
        return ""
    end
    local robloxLocaleId = LocalizationService.RobloxLocaleId
    return `{isoDate:FormatLocalTime("LL", robloxLocaleId)} {isoDate:FormatLocalTime("LT", robloxLocaleId)}`
end

return function(tbl1)
    return React.createElement(
        "ScreenGui",
        {
            DisplayOrder = 100,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            IgnoreGuiInset = true
        },
        {
            RewardsInfoModalContainer = React.createElement(Foundation.View, {
                tag = "size-full-full bg-over-media-100",
                onActivated = function()
                    if tbl1.setModalOpen then
                        tbl1.setModalOpen(false)
                    end
                end
            }, {
                RewardsInfoModal = React.createElement(PartialPageModal, {
                    title = tbl1.title,
                    screenSize = func1(),
                    position = UDim2.new(0.5, 0, 0.5, 0),
                    onCloseClicked = function()
                        if tbl1.setModalOpen then
                            tbl1.setModalOpen(false)
                        end
                    end
                }, {
                    RewardsInfoModalContent = React.createElement(
                        Foundation.View,
                        {
                            tag = "col size-full-0 auto-y gap-y-large padding-top-large",
                            Size = UDim2.new(1, 0, 0, 180)
                        },
                        {
                            RewardsInfoModalTitle = React.createElement(
                                Foundation.Text,
                                {
                                    tag = "text-title-medium auto-xy text-align-x-left text-wrap",
                                    Text = tbl1.rewardDetailsTitle,
                                    LayoutOrder = 0
                                }
                            ),
                            RewardsInfoModalBody = React.createElement(Foundation.Text, {
                                tag = "text-body-medium auto-xy text-align-x-left text-wrap padding-top-small",
                                Text = tbl1.rewardDetailsBody,
                                LayoutOrder = 1
                            }),
                            RewardsInfoModalLimitsTitle = React.createElement(Foundation.Text, {
                                tag = "text-title-medium auto-xy text-align-x-left text-wrap padding-top-medium",
                                Text = tbl1.rewardLimitsTitle,
                                LayoutOrder = 2
                            }),
                            RewardInfoExpiresText = React.createElement(Foundation.Text, {
                                tag = "text-body-medium auto-xy text-align-x-left text-wrap padding-top-small",
                                Text = tbl1.rewardsExpiresText .. " " .. func2(tbl1.expiryUtc),
                                LayoutOrder = 3
                            }),
                            RewardsInfoModalLimitsBody = React.createElement(
                                Foundation.Text,
                                {
                                    tag = "text-body-medium auto-xy text-align-x-left text-wrap",
                                    Text = tbl1.rewardLimitsBody,
                                    LayoutOrder = 4
                                }
                            ),
                            RewardsInfoModalCreatorSupportText = React.createElement(Foundation.Text, {
                                tag = "text-caption-medium auto-xy text-align-x-left text-wrap padding-top-xlarge",
                                Text = tbl1.rewardCreatorSupportText,
                                LayoutOrder = 5
                            }),
                            RewardsInfoModalTermsContainer = React.createElement(Foundation.View, {
                                tag = "row grow auto-xy align-x-left padding-top-small",
                                BackgroundTransparency = 1,
                                LayoutOrder = 6,
                                onActivated = function()
                                    local command = if bool1 then HttpService:JSONEncode({
                                        url = GetFStringReferralRewardsTermsURL(),
                                        title = tbl1.rewardsTerms,
                                        command = "open",
                                        visible = true,
                                        isGenericWebview = true,
                                        enableOverlayReplacement = true
                                    }) else HttpService:JSONEncode({ url = GetFStringReferralRewardsTermsURL(), title = tbl1.rewardsTerms, command = "open" })
                                    BrowserService:SendCommand(command)
                                end
                            }, {
                                RewardsInfoModalTermsText = React.createElement(Foundation.Text, {
                                    tag = "text-label-small auto-xy text-align-x-left text-wrap",
                                    Text = `<u><b>{tbl1.rewardsTerms}</b></u>`,
                                    RichText = true
                                })
                            })
                        }
                    )
                })
            })
        }
    )
end
