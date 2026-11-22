-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local React = require(MomentsCommonParent.React)
local useDispatch = require(MomentsCommonParent.RoactUtils).Hooks.RoactRodux.useDispatch
local AppPage = require(MomentsCommonParent.RobloxAppEnums).AppPage
local SetCurrentToastMessage = require(MomentsCommonParent.ToastRodux).Actions.SetCurrentToastMessage
local Images = require(MomentsCommonParent.UIBlox).App.ImageSet.Images
local FFlagMomentsBlockingModalInOverlay = require(MomentsCommonParent.SharedFlags).FFlagMomentsBlockingModalInOverlay

local function useOpenBlockingModal(arg1)
    local var1 = useDispatch()
    local var2 = React.useCallback(function(tbl1)
        arg1.push(AppPage.BlockingModal, {
            navProps = {
                userId = tbl1.userId,
                onBlockConfirmed = tbl1.onBlockConfirmed,
                onBlockFailed = tbl1.onBlockFailed,
                openReportUser = tbl1.openReportUser,
                presentInOverlay = if FFlagMomentsBlockingModalInOverlay then true else nil,
                onBlockSuccess = function()
                    var1(
                        SetCurrentToastMessage(
                            {
                                toastMessage = "Feature.Profile.Action.UserBlocked",
                                toastIcon = Images["icons/actions/block"]
                            }
                        )
                    )

                    if tbl1.onBlockSucceeded ~= nil then
                        tbl1.onBlockSucceeded()
                    end
                end
            }
        })
    end, { arg1, var1 })
    return if arg1 == nil then nil else var2
end

return useOpenBlockingModal
