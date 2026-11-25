-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiDataBinderTransformUtils = require(SduiCoreSystem.ClientBinding.SduiDataBinderTransformUtils)

local snakeToCamel = SduiDataBinderTransformUtils.snakeToCamel
local protobufTimestampToLocalTimeString = SduiDataBinderTransformUtils.protobufTimestampToLocalTimeString

local tbl1 = {
    DataStatus = { Ready = "Ready", NotReady = "NotReady", Failed = "Failed" }
}

return {
    createDataHydrationMock = function(tbl2)
        local tbl3 = {
            Badges = not tbl2 and {
                getBadgeInfoStore = function()
                    return {
                        getBadgeInfo = function()
                            return {
                                data = function()
                                    return nil
                                end,
                                status = function(): string
                                    return "NotReady"
                                end
                            }
                        end,
                        getBadgeInfos = function()
                            return {}
                        end,
                        clear = function() end,
                        dispose = function() end
                    }
                end
            } or tbl2.Badges or {
                getBadgeInfoStore = function()
                    return {
                        getBadgeInfo = function()
                            return {
                                data = function()
                                    return nil
                                end,
                                status = function(): string
                                    return "NotReady"
                                end
                            }
                        end,
                        getBadgeInfos = function()
                            return {}
                        end,
                        clear = function() end,
                        dispose = function() end
                    }
                end
            },
            Game = if tbl2 then tbl2.Game or nil else nil,
            SocialLink = if tbl2 then tbl2.SocialLink or nil else nil,
            MarketplaceCatalogCategory = not tbl2 and {
                getMarketplaceCatalogCategoryStore = function()
                    return {
                        getMarketplaceCatalogCategory = function()
                            return {
                                data = function()
                                    return nil
                                end,
                                status = function(): string
                                    return "NotReady"
                                end
                            }
                        end,
                        getMarketplaceCatalogCategories = function()
                            return {}
                        end,
                        updateMarketplaceCatalogCategories = function() end,
                        updateMarketplaceCatalogCategory = function() end,
                        clear = function() end,
                        dispose = function() end
                    }
                end
            } or tbl2.MarketplaceCatalogCategory or {
                getMarketplaceCatalogCategoryStore = function()
                    return {
                        getMarketplaceCatalogCategory = function()
                            return {
                                data = function()
                                    return nil
                                end,
                                status = function(): string
                                    return "NotReady"
                                end
                            }
                        end,
                        getMarketplaceCatalogCategories = function()
                            return {}
                        end,
                        updateMarketplaceCatalogCategories = function() end,
                        updateMarketplaceCatalogCategory = function() end,
                        clear = function() end,
                        dispose = function() end
                    }
                end
            },
            MarketplaceCatalogSort = not tbl2 and {
                getMarketplaceCatalogSortStore = function()
                    return {
                        getMarketplaceCatalogSort = function()
                            return {
                                data = function()
                                    return nil
                                end,
                                status = function(): string
                                    return "NotReady"
                                end
                            }
                        end,
                        getMarketplaceCatalogSorts = function()
                            return {}
                        end,
                        updateMarketplaceCatalogSorts = function() end,
                        updateMarketplaceCatalogSort = function() end,
                        clear = function() end,
                        dispose = function() end
                    }
                end
            } or tbl2.MarketplaceCatalogSort or {
                getMarketplaceCatalogSortStore = function()
                    return {
                        getMarketplaceCatalogSort = function()
                            return {
                                data = function()
                                    return nil
                                end,
                                status = function(): string
                                    return "NotReady"
                                end
                            }
                        end,
                        getMarketplaceCatalogSorts = function()
                            return {}
                        end,
                        updateMarketplaceCatalogSorts = function() end,
                        updateMarketplaceCatalogSort = function() end,
                        clear = function() end,
                        dispose = function() end
                    }
                end
            },
            Song = if tbl2 then tbl2.Song or nil else nil,
            MarketplaceAsset = if tbl2 then tbl2.MarketplaceAsset or nil else nil,
            MarketplaceBundle = if tbl2 then tbl2.MarketplaceBundle or nil else nil,
            MarketplaceLook = if tbl2 then tbl2.MarketplaceLook or nil else nil,
            MarketplaceItemFavorite = if tbl2 then tbl2.MarketplaceItemFavorite or nil else nil,
            CollectibleItem = if tbl2 then tbl2.CollectibleItem or nil else nil,
            MediaAsset = if tbl2 then tbl2.MediaAsset or nil else nil,
            UserProfile = if tbl2 then tbl2.UserProfile or nil else nil,
            Community = if tbl2 then tbl2.Community or nil else nil,
            CommunityUserMembership = if tbl2 then tbl2.CommunityUserMembership or nil else nil,
            NotificationBadge = if tbl2 then tbl2.NotificationBadge or nil else nil,
            LeaderboardStats = if tbl2 then tbl2.LeaderboardStats or nil else nil,
            BuyRobux = if tbl2 then tbl2.BuyRobux or nil else nil,
            DataHydrationTypes = tbl1
        }

        if tbl2 and tbl2.extraFields then
            for k, extraField in tbl2.extraFields do
                tbl3[k] = extraField
            end
        end

        return tbl3
    end,
    createSduiDataBinderTransformUtilsMock = function()
        return {
            snakeToCamel = snakeToCamel,
            protobufTimestampToLocalTimeString = protobufTimestampToLocalTimeString
        }
    end,
    snakeToCamel = snakeToCamel,
    protobufTimestampToLocalTimeString = protobufTimestampToLocalTimeString,
    DataHydrationTypesMock = tbl1
}
