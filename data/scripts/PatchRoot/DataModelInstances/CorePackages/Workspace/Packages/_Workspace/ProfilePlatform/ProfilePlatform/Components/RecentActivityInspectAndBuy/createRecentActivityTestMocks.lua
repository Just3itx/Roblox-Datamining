-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local Rodux = require(ProfilePlatformParent.Rodux)

local captured = {
    sheetRootProps = nil,
    dialogRootProps = nil,
    dialogTitleProps = nil,
    dialogActionsProps = nil
}

local function renderChildren(arg1)
    return React.createElement("Frame", nil, arg1.children or arg1[React.Children])
end

local tbl2 = {
    ["Feature.Catalog.Label.BuyItems"] = "Buy Items",
    ["Feature.Profile.Header.BuyWholeLook"] = "Buy whole look",
    ["IAPExperience.PurchasePrompt.Header.BuyAvatar"] = "Buy avatar",
    ["IAPExperience.PurchasePrompt.Action.Buy"] = "Buy",
    ["IAPExperience.PurchasePrompt.Label.TotalPriceV2"] = "Total price",
    ["IAPExperience.InsufficientRobux.Title.InsufficientRobux"] = "Not enough Robux",
    ["IAPExperience.InsufficientRobux.Text.CurrentBalance"] = "Current balance",
    ["IAPExperience.InsufficientRobux.Text.MissingRobux"] = "You need",
    ["IAPExperience.InsufficientRobux.Action.BuyRobux"] = "Buy Robux"
}

local PriceStatus = {
    Owned = "Owned",
    Free = "Free",
    PurchaseFromRoblox = "PurchaseFromRoblox",
    PurchaseFromResale = "PurchaseFromResale",
    OffSale = "OffSale",
    SoldOut = "SoldOut",
    Unavailable = "Unavailable",
    InExperienceOnly = "InExperienceOnly",
    QuantityLimitReached = "QuantityLimitReached"
}

local function getPriceStatusInShop(arg1)
    if not arg1 then
        return PriceStatus.Unavailable
    end

    if arg1.isOwned then
        return PriceStatus.Owned
    end

    if arg1.isOffSale then
        return PriceStatus.OffSale
    end

    if arg1.collectibleItemDetails then
        return PriceStatus.PurchaseFromResale
    end

    if arg1.priceInRobux == 0 then
        return PriceStatus.Free
    end

    if arg1.priceInRobux then
        return PriceStatus.PurchaseFromRoblox
    end

    return PriceStatus.Unavailable
end

return {
    captured = captured,
    resetCaptured = function()
        captured.sheetRootProps = nil
        captured.dialogRootProps = nil
        captured.dialogTitleProps = nil
        captured.dialogActionsProps = nil
    end,
    createFoundationMock = function(arg1)
        return (setmetatable({
            Sheet = {
                Root = function(sheetRootProps) -- name: SheetRoot
                    captured.sheetRootProps = sheetRootProps
                    return renderChildren(sheetRootProps)
                end,
                Header = renderChildren,
                Content = renderChildren,
                Actions = renderChildren
            },
            Dialog = {
                Root = function(dialogRootProps) -- name: DialogRoot
                    captured.dialogRootProps = dialogRootProps
                    return renderChildren(dialogRootProps)
                end,
                Title = function(dialogTitleProps) -- name: DialogTitle
                    captured.dialogTitleProps = dialogTitleProps
                    return React.createElement("Frame")
                end,
                Content = renderChildren,
                Actions = function(dialogActionsProps) -- name: DialogActions
                    captured.dialogActionsProps = dialogActionsProps
                    return React.createElement("Frame")
                end
            }
        }, { __index = arg1 }))
    end,
    createLocalizationMock = function()
        return {
            Hooks = {
                useLocalization = function(tbl4)
                    local result = ({})
                    for value, value2 in tbl4 do
                        if type(value2) == "table" then
                            value2 = value2[1]
                        end

                        result[value] = tbl2[value2] or value2
                    end
                    return result
                end
            },
            NumberLocalization = {
                localize = function(num1: number, _: string?): string
                    return tostring(num1)
                end
            }
        }
    end,
    createInspectAndBuyMock = function(components)
        return {
            Components = components or {},
            Utils = {
                getPriceStatusInShop = getPriceStatusInShop,
                getPriceLineContent = function(_, _, _)
                    return {}
                end
            },
            Enums = { PriceStatus = PriceStatus },
            Constants = {
                AssetLocalizationKeys = {},
                BundleLocalizationKeys = {},
                PriceStatusLocalizationKeys = {}
            }
        }
    end,
    createMockStore = function()
        return Rodux.Store.new(function()
            return {
                ScreenSize = Vector2.new(800, 600),
                TopBar = { statusBarHeight = 0 }
            }
        end, {}, { Rodux.thunkMiddleware })
    end,
    makeDisplayItem = function(tbl4)
        local tbl5 = {
            id = "1",
            name = "Test Item",
            priceInRobux = 100,
            itemSubType = "8",
            creator = { creatorName = "Creator", creatorHasVerifiedBadge = false },
            isOwned = false,
            isOffSale = false,
            saleLocationType = "ShopAndAllExperiences",
            collectibleProductId = "product-1",
            itemType = "Asset",
            bundlePartsCount = 0,
            bundleAssetIds = {}
        }
        if tbl4 then
            for value, value2 in tbl4 do
                tbl5[value] = value2
            end
        end
        return tbl5
    end,
    PriceStatus = PriceStatus
}
