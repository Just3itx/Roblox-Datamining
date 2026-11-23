-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AdService = game:GetService("AdService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local ColorMode = require(scriptParentParent.Foundation).Enums.ColorMode

local UIBlox = require(scriptParentParent.UIBlox)

local AdsEuDsaPromptUI = require(script.Parent.AdsEuDsaPromptUI)

local RobloxTranslator = require(scriptParentParent.RobloxTranslator)

local function getBodyText(advertiserName: string, payerName: string)
    if advertiserName ~= "" and payerName == "" then
        return RobloxTranslator:FormatByKey("CoreScripts.Ads.Label.InExperienceDisclosureDynamic", { AdvertiserName = advertiserName })
    elseif advertiserName ~= "" and payerName ~= "" then
        return RobloxTranslator:FormatByKey(
            "CoreScripts.Ads.Label.InExperienceDisclosureDynamicWithPayer",
            { AdvertiserName = advertiserName, PayerName = payerName }
        )
    end

    return RobloxTranslator:FormatByKey("CoreScripts.Ads.Label.InExperienceDisclosureStatic")
end

local var1 = Roact.PureComponent:extend("AdsEuDsaPromptHandler")

function var1.init(arg1)
    arg1:setState({ enabled = false })

    arg1.savedSelectedCoreObject = nil

    arg1:setState({ bodyText = "" })

    AdService.ShowDynamicEudsaDisclosure:Connect(function(advertiserName: string, payerName: string)
        arg1:setState({ bodyText = getBodyText(advertiserName, payerName) })

        arg1:showPrompt()
    end)
end

function var1.saveSelectedObject(arg1)
    arg1.savedSelectedCoreObject = GuiService.SelectedCoreObject
    GuiService.SelectedCoreObject = nil
end

function var1.restoreSelectedObject(arg1)
    if arg1.savedSelectedCoreObject == nil or arg1.savedSelectedCoreObject:IsDescendantOf(CoreGui) then
        GuiService.SelectedCoreObject = arg1.savedSelectedCoreObject
    end
end

function var1.showPrompt(arg1)
    arg1:saveSelectedObject()
    arg1:setState({ enabled = true })
end

function var1.hidePrompt(arg1)
    arg1:setState({ enabled = false })

    AdService:HideEudsaDisclosure()
    arg1:restoreSelectedObject()
end

function var1.render(handler)
    if not handler.state.enabled then
        return nil
    end

    local appStyleProvider = UIBlox.App.Style.AppStyleProvider
    local constants = UIBlox.App.Style.Constants
    local tbl1 = {
        Dark = {
            themeName = ColorMode.Dark,
            fontName = constants.FontName.Gotham
        }
    }

    local prompt = Roact.createElement(AdsEuDsaPromptUI, { handler = handler, bodyText = handler.state.bodyText })

    return (Roact.createElement(
        "ScreenGui",
        {
            ResetOnSpawn = false,
            IgnoreGuiInset = true,
            DisplayOrder = 15,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            AutoLocalize = false,
            Enabled = handler.state.enabled
        },
        Roact.createElement(appStyleProvider, {
            style = tbl1.Dark
        }, {
            Frame = Roact.createElement("Frame", {
                Selectable = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5)
            }, {
                Prompt = prompt,
                ModalFix = Roact.createElement("ImageButton", { BackgroundTransparency = 0, Modal = true, Size = UDim2.new(0, 0, 0, 0) })
            })
        })
    ))
end

return var1
