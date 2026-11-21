-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local CollectionService = game:GetService("CollectionService")

local React = require(GamePlayButtonParent.React)

local UIBlox = require(GamePlayButtonParent.UIBlox)
local Button = UIBlox.App.Button.Button
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local ComboButton = UIBlox.App.Button.ComboButton
local Images = UIBlox.App.ImageSet.Images
local MenuDirection = UIBlox.App.Menu.MenuDirection

local Foundation = require(GamePlayButtonParent.Foundation)
local Button2 = Foundation.Button
local IconButton = Foundation.IconButton
local Skeleton = Foundation.Skeleton
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local InputSize = Foundation.Enums.InputSize
local Radius = Foundation.Enums.Radius

local _GameProductInfoRodux = require(GamePlayButtonParent.GameProductInfoRodux)
local PlayButtonStates = require(script.Parent.PlayButtonStates)
local EarlyAccessPlusTooltip = require(script.Parent.EarlyAccess.EarlyAccessPlusTooltip)

local SharedFlags = require(GamePlayButtonParent.SharedFlags)
local FFlagLuaAppPlayButtonPrivatePT = SharedFlags.FFlagLuaAppPlayButtonPrivatePT
local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled
local FFlagLuaAppUnifyPlayButtonAllSurfacesIxp = SharedFlags.FFlagLuaAppUnifyPlayButtonAllSurfacesIxp
local FFlagLuaAppJoinTextPlayableButton = SharedFlags.FFlagLuaAppJoinTextPlayableButton
local FFlagLuaAppIconPlayButton = SharedFlags.FFlagLuaAppIconPlayButton
local FFlagLuaAppPlayButtonLoadingSkeleton = SharedFlags.FFlagLuaAppPlayButtonLoadingSkeleton
local FFlagLuaAppUnifiedPlayButtonSquadMenuDirection = SharedFlags.FFlagLuaAppUnifiedPlayButtonSquadMenuDirection
local GetFFlagUIBloxUseFoundationButton = SharedFlags.UIBlox.GetFFlagUIBloxUseFoundationButton
local FFlagLuaAppPlayButtonOptOutFoundationButton = SharedFlags.FFlagLuaAppPlayButtonOptOutFoundationButton
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppTextOnlyPlayButton = SharedFlags.FFlagLuaAppTextOnlyPlayButton
local FFlagLuaAppIconTextPlayButton = SharedFlags.FFlagLuaAppIconTextPlayButton
local FFlagLuaAppUpdatePlayButtonText = SharedFlags.FFlagLuaAppUpdatePlayButtonText
local FFlagLuaAppUseTokenHeightForPlayButton = SharedFlags.FFlagLuaAppUseTokenHeightForPlayButton
local FFlagEnableGameJoinEarlyAccess = SharedFlags.FFlagEnableGameJoinEarlyAccess

local var1 = if FFlagLuaAppIconPlayButton then "play-xlarge" else nil

local iconsCommonPlay = Images["icons/common/play"]
local iconsActionsTruncationCollapse = Images["icons/actions/truncationCollapse"]
local iconsActionsTruncationExpand = Images["icons/actions/truncationExpand"]

local function func1() end

local ButtonHeightSizeKeyByInputSize = require(script.Parent.ButtonHeightSizeKeyByInputSize)

return React.memo(function(tbl1) -- name: PlayButtonView
    local tokens = tbl1.tokens
    local playButtonState = tbl1.playButtonState
    local localized = tbl1.localized

    local element = nil

    local onPlayButtonActivated = tbl1.onPlayButtonActivated
    local bool1, var2

    if FFlagEnableGameJoinEarlyAccess then
        bool1 = tbl1.showEarlyAccessTooltip == true
        local isOpen, var4 = React.useState(bool1)
        var2 = React.useRef(nil)

        if bool1 then
            element = React.createElement(EarlyAccessPlusTooltip, {
                isOpen = isOpen,
                onRequestClose = function()
                    var4(false)
                end,
                anchorRef = var2
            })

            onPlayButtonActivated = function()
                var4(false)
                tbl1.onPlayButtonActivated()
            end
        end
    else
        bool1 = false
        var2 = nil
    end

    local playButtonCaptureRef

    if FFlagLuaAppMediaGalleryGamepadSupport then
        local tag = tbl1.tag
        local playButtonCaptureRef2 = tbl1.playButtonCaptureRef
        local var3 = React.useRef(nil)
        playButtonCaptureRef = React.useCallback(function(instance: Instance)
            local current = var3.current
            if current ~= nil and current ~= instance and tag ~= nil then
                CollectionService:RemoveTag(current, tag)
            end
            var3.current = instance
            if tag ~= nil and instance ~= nil then
                CollectionService:AddTag(instance, tag)
            end
            if type(playButtonCaptureRef2) == "function" then
                playButtonCaptureRef2(instance)
            elseif playButtonCaptureRef2 ~= nil then
                playButtonCaptureRef2.current = instance
            end
        end, { tag, playButtonCaptureRef2 })
    else
        playButtonCaptureRef = nil
    end

    local bool2 = false
    local bool3 = false
    local bool4 = false
    local size = tbl1.buttonSize or InputSize.Medium
    local var4

    if FFlagLuaAppUseTokenHeightForPlayButton then
        local var5 = ButtonHeightSizeKeyByInputSize[size] or "Size_1000"
        var4 = if tokens then if tokens.Size[var5] then tokens.Size[var5] else 40 else 40
    else
        var4 = nil
    end

    local fillBehavior = if tbl1.width then FillBehavior.Fill else tbl1.fillBehavior
    local var6 = nil
    local var7 = nil
    local var8 = nil
    local element2 = nil
    local x = nil

    local bool5 = FFlagEnableGameJoinEarlyAccess

    if bool5 then
        if playButtonState == PlayButtonStates.EarlyAccessLocked then
            bool5 = tbl1.earlyAccessPending == true
        else
            bool5 = false
        end
    end

    if playButtonState == PlayButtonStates.Loading then
        if tbl1.hideIfLoading then
            return nil
        end

        if FFlagLuaAppPlayButtonLoadingSkeleton
            and not tbl1.useUIBloxButton
            and (not FFlagLuaAppUnifyPlayButtonAllSurfacesIxp or tbl1.hasPlayButtonLoadingSkeletonIxp)
        then
            local offset

            if FFlagLuaAppUseTokenHeightForPlayButton then
                offset = var4
            else
                local var9 = ButtonHeightSizeKeyByInputSize[size] or "Size_1000"
                offset = tokens and tokens.Size[var9]
            end
            if fillBehavior == "Fill" then
                x = UDim.new(1, 0)
            else
                x = UDim.new(0, offset)
            end

            local uDim2 = UDim2.new(x, UDim.new(0, offset))
            local var9 = FFlagLuaAppUnifyPlayButtonAllSurfacesIxp or tbl1.shouldLaunchWhenLoading or tbl1.shouldLaunchOnReleaseAfterUnmount

            element2 = React.createElement(
                Skeleton,
                {
                    Size = if var9 then UDim2.fromScale(1, 1) else uDim2,
                    radius = Radius.Medium,
                    ZIndex = 2
                }
            )

            if var9 then
                element2 = React.createElement("TextButton", {
                    Size = uDim2,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Text = "",
                    AutoButtonColor = false,
                    ZIndex = 2,
                    ref = tbl1.loadingCaptureRef,
                    [React.Event.Activated] = tbl1.onPlayButtonActivated
                }, { Skeleton = element2 })
            end

            bool4 = true
        end

        var6 = ButtonVariant.Emphasis
    elseif playButtonState == PlayButtonStates.Playable then
        var6 = ButtonVariant.Emphasis
        if FFlagLuaAppIconTextPlayButton
            or FFlagLuaAppTextOnlyPlayButton
            or FFlagLuaAppJoinTextPlayableButton and (not FFlagLuaAppUnifyPlayButtonAllSurfacesIxp or tbl1.hasJoinTextPlayableButtonIxp)
        then
            var8 = tbl1.playableText

            if not var8 then
                if FFlagLuaAppUpdatePlayButtonText then
                    var8 = localized.play
                else
                    var8 = localized.join
                end
            end

            if FFlagLuaAppIconTextPlayButton and not tbl1.hidePlayableIcon then
                var7 = var1
            end
        else
            if not (FFlagLuaAppIconPlayButton or tbl1.hidePlayableIcon) then
                var7 = "icons/common/play"
            end

            var8 = tbl1.playableText

            if FFlagLuaAppIconPlayButton and not tbl1.hidePlayableIcon then
                if var8 and var8 ~= "" then
                    var7 = "icons/common/play"
                else
                    var7 = var1
                end
            end
        end
    elseif GetFFlagIsSquadEnabled() and playButtonState == PlayButtonStates.PlayableWithParty then
        var7 = iconsCommonPlay
        if tbl1.hideOptionalText then
            var8 = nil
        else
            var8 = localized.joinWithParty
        end

        bool2 = true
    elseif GetFFlagIsSquadEnabled() and playButtonState == PlayButtonStates.WaitingForParty then
        var7 = iconsCommonPlay
        if tbl1.hideOptionalText then
            var8 = nil
        else
            var8 = localized.waitingForParty
        end

        bool2 = true
        bool4 = true
        bool3 = true
    elseif playButtonState == PlayButtonStates.PaidAccess then
        var8 = tostring(tbl1.gameProductInfo and tbl1.gameProductInfo.price or 0)
        var6 = ButtonVariant.Emphasis
        var7 = "icons/common/robux"
    elseif playButtonState == PlayButtonStates.FiatPaidAccess then
        var6 = ButtonVariant.Emphasis
        local localizedFiatPrice = tbl1.gameProductInfo and tbl1.gameProductInfo.localizedFiatPrice or ""
        var8 = tbl1.fiatText or localizedFiatPrice
    elseif playButtonState == PlayButtonStates.DemoMode then
        var6 = ButtonVariant.SubEmphasis
        var8 = localized.playDemo
    elseif FFlagLuaAppPlayButtonPrivatePT and playButtonState == PlayButtonStates.Playtest then
        var6 = ButtonVariant.SubEmphasis
        var8 = localized.playtest
    elseif playButtonState == PlayButtonStates.ActionNeeded then
        var6 = ButtonVariant.Emphasis
        var8 = localized.unlock
    elseif playButtonState == PlayButtonStates.UnplayableOther then
        if tbl1.hideIfUnplayable then
            return nil
        end
        var6 = ButtonVariant.Subtle
        var7 = "icons/status/unavailable"
        if tbl1.hideOptionalText then
            var8 = nil
        else
            var8 = localized.unavailable
        end

        bool4 = true
    elseif FFlagEnableGameJoinEarlyAccess and playButtonState == PlayButtonStates.EarlyAccessLocked then
        var6 = ButtonVariant.Subtle
        if bool5 then
            var8 = nil
        else
            var8 = tbl1.earlyAccessCaption or localized.earlyAccess
        end

        bool4 = true
    else
        error("invalid play button state!")
    end

    local var9

    if bool2 then
        if not FFlagLuaAppUseTokenHeightForPlayButton then
            local var10 = ButtonHeightSizeKeyByInputSize[size] or "Size_1000"
            var4 = if tokens then if tokens.Size[var10] then tokens.Size[var10] else 40 else 40
        end

        local createElement = React.createElement
        local var10 = ComboButton
        local tbl2 = {
            size = UDim2.new(1, 0, 0, var4),
            button = {
                icon = var7,
                text = var8,
                isDisabled = bool4,
                onActivated = bool4 and function() end or onPlayButtonActivated
            },
            overflow = {
                icon = if FFlagLuaAppUnifiedPlayButtonSquadMenuDirection and tbl1.squadButtonMenuDirection == MenuDirection.Down then iconsActionsTruncationExpand else iconsActionsTruncationCollapse,
                isDisabled = bool3,
                onActivated = bool3 and function() end or tbl1.onPlaySquadButtonActivated
            },
            testId = tbl1.testId
        }
        var9 = createElement(var10, tbl2)
    elseif tbl1.useUIBloxButton then
        if not FFlagLuaAppUseTokenHeightForPlayButton then
            local var10 = ButtonHeightSizeKeyByInputSize[size] or "Size_1000"
            var4 = if tokens then if tokens.Size[var10] then tokens.Size[var10] else 40 else 40
        end
        local fitContent = fillBehavior == "Fit"
        local uDim2 = if fitContent then UDim2.new(0, 0, 0, var4) else UDim2.new(1, 0, 0, var4)
        local isLoading = playButtonState == PlayButtonStates.Loading
        local buttonType = if var6 == ButtonVariant.SubEmphasis then ButtonType.PrimarySystem elseif var6 == ButtonVariant.Subtle then ButtonType.Secondary else ButtonType.PrimaryContextual

        if var7 == var1 then
            var7 = iconsCommonPlay
        end
        if type(var7) == "string" then
            var7 = Images[var7]
        end

        local createElement = React.createElement
        local var11 = Button
        local tbl2 = {
            size = uDim2,
            fitContent = fitContent,
            buttonType = buttonType,
            icon = var7,
            text = var8,
            isLoading = isLoading or bool5,
            isDisabled = bool4 or isLoading,
            userInteractionEnabled = not (bool4 or isLoading)
        }

        if bool4 or isLoading then
            onPlayButtonActivated = func1
        end

        tbl2.onActivated = onPlayButtonActivated
        if not FFlagLuaAppMediaGalleryGamepadSupport then
            playButtonCaptureRef = tbl1.playButtonCaptureRef
        end

        tbl2.ref = playButtonCaptureRef
        local tag = React.Tag
        tbl2[tag] = if tbl1.testId then `data-testid={tbl1.testId}` else nil
        tbl2.DO_NOT_USE_useUIBloxButton = if GetFFlagUIBloxUseFoundationButton() then true elseif FFlagLuaAppPlayButtonOptOutFoundationButton then true else nil
        var9 = createElement(var11, tbl2)

        if (FFlagLuaAppUnifyPlayButtonAllSurfacesIxp or tbl1.shouldLaunchWhenLoading or tbl1.shouldLaunchOnReleaseAfterUnmount)
            and isLoading
        then
            element2 = React.createElement("TextButton", {
                Size = uDim2,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                ZIndex = 2,
                ref = tbl1.loadingCaptureRef,
                [React.Event.Activated] = tbl1.onPlayButtonActivated
            })
        end
    else
        local var10 = if FFlagLuaAppIconPlayButton then (var8 == nil or var8 == "") and var7 ~= nil else nil

        if FFlagLuaAppIconPlayButton and (not FFlagLuaAppUnifyPlayButtonAllSurfacesIxp or tbl1.hasIconPlayButtonIxp) and var10 then
            local createElement = React.createElement
            local var11 = IconButton
            local tbl2 = {
                icon = var7,
                variant = var6,
                size = size,
                width = 0,
                fillBehavior = 0,
                isDisabled = 0,
                onActivated = 0,
                ref = 0,
                testId = 0
            }

            if not FFlagLuaAppPlayButtonLoadingSkeleton or playButtonState ~= PlayButtonStates.Loading then
                x = nil
            end

            tbl2.width = x

            tbl2.fillBehavior = fillBehavior
            tbl2.isDisabled = bool4
            if bool4 then
                onPlayButtonActivated = func1
            end

            tbl2.onActivated = onPlayButtonActivated
            if not FFlagLuaAppMediaGalleryGamepadSupport then
                playButtonCaptureRef = tbl1.playButtonCaptureRef
            end

            tbl2.ref = playButtonCaptureRef
            tbl2.testId = tbl1.testId
            var9 = createElement(var11, tbl2)
        else
            local createElement = React.createElement
            local var11 = Button2
            local tbl2 = {
                icon = var7,
                text = var8,
                variant = var6,
                size = size,
                width = 0,
                fillBehavior = 0,
                isLoading = 0,
                isDisabled = 0,
                onActivated = 0,
                ref = 0,
                testId = 0
            }

            if not FFlagLuaAppPlayButtonLoadingSkeleton or playButtonState ~= PlayButtonStates.Loading then
                x = nil
            end

            tbl2.width = x

            tbl2.fillBehavior = fillBehavior
            tbl2.isLoading = if bool5 then true else nil
            tbl2.isDisabled = bool4
            if bool4 then
                onPlayButtonActivated = func1
            end

            tbl2.onActivated = onPlayButtonActivated
            if not FFlagLuaAppMediaGalleryGamepadSupport then
                playButtonCaptureRef = tbl1.playButtonCaptureRef
            end

            tbl2.ref = playButtonCaptureRef
            tbl2.testId = tbl1.testId
            var9 = createElement(var11, tbl2)
        end
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {}
    if not (FFlagEnableGameJoinEarlyAccess and bool1) then
        var2 = nil
    end

    tbl2.ref = var2
    tbl2.LayoutOrder = tbl1.LayoutOrder
    tbl2.Position = tbl1.Position
    local var10

    if FFlagLuaAppUseTokenHeightForPlayButton then
        var10 = UDim2.new(
            if tbl1.width then tbl1.width elseif fillBehavior == "Fill" then UDim.new(1, 0) else UDim.new(0, 0),
            UDim.new(0, var4)
        )
    elseif tbl1.width then
        var10 = UDim2.new(tbl1.width, UDim.new(0, 0))
    elseif fillBehavior == "Fill" then
        var10 = UDim2.new(1, 0, 1, 0)
    else
        var10 = nil
    end

    tbl2.Size = var10

    tbl2.AutomaticSize = if FFlagLuaAppUseTokenHeightForPlayButton then if fillBehavior == "Fill" then nil else Enum.AutomaticSize.X elseif fillBehavior == "Fill" then Enum.AutomaticSize.Y else Enum.AutomaticSize.XY

    tbl2.BackgroundTransparency = 1
    tbl2.BorderSizePixel = 0
    local tag = React.Tag
    tbl2[tag] = if FFlagLuaAppMediaGalleryGamepadSupport then nil else tbl1.tag
    local tbl3 = { LoadingSkeleton = 0, PlayButton = 0, EarlyAccessTooltip = 0 }
    if playButtonState ~= PlayButtonStates.Loading then
        element2 = nil
    end

    tbl3.LoadingSkeleton = element2
    tbl3.PlayButton = var9
    if not FFlagEnableGameJoinEarlyAccess then
        element = nil
    end

    tbl3.EarlyAccessTooltip = element
    return createElement(str1, tbl2, tbl3)
end)
