-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AvatarExperienceNavigation = script:FindFirstAncestor("AvatarExperienceNavigation")
local AvatarExperienceNavigationParent = AvatarExperienceNavigation.Parent

local AvatarScreen = require(AvatarExperienceNavigation.Enums.AvatarScreen)
local UnifiedLoggingSurface = require(AvatarExperienceNavigation.Enums.UnifiedLoggingSurface)
local Cryo = require(AvatarExperienceNavigationParent.Cryo)
local _Dash = require(AvatarExperienceNavigationParent.Dash)
local AvatarExperienceFlags = require(AvatarExperienceNavigationParent.AvatarExperienceFlags)
local FFlagAXEditorSubcategoryFilters = AvatarExperienceFlags.FFlagAXEditorSubcategoryFilters
local FFlagAXEnableExpiredUserLookCheckout = AvatarExperienceFlags.FFlagAXEnableExpiredUserLookCheckout
local FFlagAXOutfitPageRevamp = AvatarExperienceFlags.FFlagAXOutfitPageRevamp
local FFlagAXAvatarFoldersEnabled = AvatarExperienceFlags.FFlagAXAvatarFoldersEnabled
local FFlagAXBackgroundGenerationAnalytics = AvatarExperienceFlags.FFlagAXBackgroundGenerationAnalytics
local FFlagAXPhotoboothMomentsPage = AvatarExperienceFlags.FFlagAXPhotoboothMomentsPage
local FFlagAXPhotoboothMomentsLogging = AvatarExperienceFlags.FFlagAXPhotoboothMomentsLogging

local bool1 = game:DefineFastFlag("AXKeepTryOnsInAvatarEditor", false)
local FFlagAXFixAvatarScreenVR = AvatarExperienceFlags.FFlagAXFixAvatarScreenVR
local FFlagAXGifting = AvatarExperienceFlags.FFlagAXGifting
local FFlagAXMakeupReleaseFTUX = AvatarExperienceFlags.FFlagAXMakeupReleaseFTUX
local FFlagAXCatalogMakeupSupport = AvatarExperienceFlags.FFlagAXCatalogMakeupSupport
local FFlagAXEnableProfileTab = require(AvatarExperienceNavigationParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagEditProfileImageV2Enabled = require(AvatarExperienceNavigationParent.SharedFlags).FFlagEditProfileImageV2Enabled

local tbl1 = {
    isTransparent = false,
    coversSceneWhenExpanded = false,
    isTryOnOutfitResetPage = false,
    isRefinementPage = false,
    refinementButtonVisible = false,
    VRPanelRoundedCorners = false,
    VRPanelPlacement = "Center"
}

local tbl2 = {
    [AvatarScreen.AccessoryAdjustment] = {
        isRefinementPage = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.AvatarExperienceLandingPage] = { isTryOnOutfitResetPage = true },
    [AvatarScreen.AvatarExperienceRoot] = {},
    [AvatarScreen.AvatarBackground] = { isTransparent = false },
    [AvatarScreen.BackgroundGeneration] = {
        analyticsData = FFlagAXBackgroundGenerationAnalytics and {
            unifiedLoggingSurface = UnifiedLoggingSurface.BACKGROUND_GENERATION
        } or nil
    },
    [AvatarScreen.Catalog] = {
        refinementButtonVisible = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CATALOG
        }
    },
    [AvatarScreen.CatalogContextMenu] = { VRPanelPlacement = "Right" },
    [AvatarScreen.CatalogSearch] = {
        refinementButtonVisible = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.SEARCH_RESULTS
        }
    },
    [AvatarScreen.CatalogSearchLanding] = {
        refinementButtonVisible = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.SEARCH_LANDING_PAGE
        }
    },
    [AvatarScreen.ItemDetails] = {
        isTransparent = true,
        coversSceneWhenExpanded = true,
        VRPanelPlacement = "Right",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.OutfitDetails] = {
        isTransparent = true,
        coversSceneWhenExpanded = true,
        VRPanelPlacement = "Right",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.ItemOwnershipPage] = {
        isTransparent = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.CreateOrUpdateOutfitMenu] = { VRPanelPlacement = "Left" },
    [AvatarScreen.LayeredClothingSort] = {
        isRefinementPage = true,
        VRPanelPlacement = "Center",
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.LCSortContextMenu] = { VRPanelPlacement = "Right" },
    [AvatarScreen.AvatarEditor] = {
        isTryOnOutfitResetPage = not bool1,
        refinementButtonVisible = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.AvatarRefinement] = {
        VRPanelPlacement = "Right",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.ManageOutfitPage] = {
        isTransparent = false,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.ProfilePictureEditorEmotes] = { isTryOnOutfitResetPage = true },
    [AvatarScreen.ResellersPage] = {
        isTransparent = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.SellItemPage] = {
        isTransparent = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.SellItemPeekView] = {
        isTransparent = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.SortAndFilters] = { isTransparent = true, VRPanelPlacement = "Left" },
    [AvatarScreen.TryOnItem] = {
        isTransparent = false,
        VRPanelPlacement = "Right",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.UpdateOutfitPage] = {
        isTransparent = true,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true
    },
    [AvatarScreen.AdjustAccessoryView] = {
        isTransparent = false,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.HeadRefinement] = {
        isRefinementPage = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.LookDetails] = {
        isTransparent = true,
        coversSceneWhenExpanded = true,
        VRPanelPlacement = "Right",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.ITEM_DETAILS
        }
    },
    [AvatarScreen.ContextMenu] = { VRPanelPlacement = "Right" },
    [AvatarScreen.MySharedAvatars] = {
        isTryOnOutfitResetPage = true,
        refinementButtonVisible = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.FavoritesSaved] = {
        refinementButtonVisible = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true
    },
    [AvatarScreen.CommunityAvatarEntryMenu] = { VRPanelPlacement = "Left" },
    [AvatarScreen.SearchLandingFocusedWidgetPage] = {
        refinementButtonVisible = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.SEARCH_LANDING_PAGE
        }
    },
    [AvatarScreen.BodyShape] = {
        isRefinementPage = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.AvatarSwitcher] = {
        isTransparent = false,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    },
    [AvatarScreen.EditEmotes] = {
        isTransparent = false,
        isTryOnOutfitResetPage = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
}

if FFlagAXOutfitPageRevamp then
    tbl2[AvatarScreen.AddOutfitDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.DuplicateOutfitDialog] = { isTransparent = false, VRPanelPlacement = "Left" }

    tbl2[AvatarScreen.DuplicateOutfitNameDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left"
    }

    tbl2[AvatarScreen.RenameOutfitDialog] = { isTransparent = false, VRPanelPlacement = "Right" }

    tbl2[AvatarScreen.DeleteOutfitDialog] = { isTransparent = false, VRPanelPlacement = "Right" }

    tbl2[AvatarScreen.BulkDeleteOutfitDialog] = { isTransparent = false, VRPanelPlacement = "Left" }

    tbl2[AvatarScreen.ManageOutfitsPage] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
end

if FFlagAXAvatarFoldersEnabled then
    tbl2[AvatarScreen.CreateFolderDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.RenameFolderDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.DuplicateFolderNameDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.FolderNameNotAllowedDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.FolderLimitReachedDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.FolderErrorDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.DeleteFolderPrompt] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.SelectFolderMenu] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.RemoveFromFolderDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
    tbl2[AvatarScreen.FolderItemsErrorDialog] = {
        isTransparent = false,
        VRPanelPlacement = "Left",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
end

if FFlagAXFixAvatarScreenVR then
    if FFlagAXCatalogMakeupSupport then
        tbl2[AvatarScreen.MakeupMax6LayersPrompt] = {
            isTransparent = false,
            VRPanelPlacement = "Left",
            VRPanelRoundedCorners = true
        }
    end

    if FFlagAXMakeupReleaseFTUX then
        tbl2[AvatarScreen.MakeupReleaseFtuxPrompt] = {
            isTransparent = false,
            VRPanelPlacement = "Left",
            VRPanelRoundedCorners = true
        }
    end
end

if FFlagAXEditorSubcategoryFilters then
    tbl2[AvatarScreen.SubcategoryFiltersDropdown] = {
        isTransparent = true,
        VRPanelPlacement = "Left"
    }
end

tbl2[AvatarScreen.Checkout] = {
    isTransparent = true,
    coversSceneWhenExpanded = true,
    VRPanelPlacement = "Right",
    VRPanelRoundedCorners = true,
    analyticsData = {
        unifiedLoggingSurface = UnifiedLoggingSurface.CATALOG
    }
}

if FFlagAXEnableProfileTab then
    tbl2[AvatarScreen.Profile] = {
        refinementButtonVisible = true,
        isTryOnOutfitResetPage = true,
        VRPanelPlacement = "None",
        VRPanelRoundedCorners = true
    }
end

if FFlagAXEnableExpiredUserLookCheckout then
    tbl2[AvatarScreen.ExpiredUserLookActionBar] = {
        isTransparent = true,
        VRPanelPlacement = "Right",
        VRPanelRoundedCorners = true
    }

    tbl2[AvatarScreen.ExpiredUserLookCheckout] = {
        isTransparent = true,
        coversSceneWhenExpanded = true,
        VRPanelPlacement = "Right",
        VRPanelRoundedCorners = true,
        analyticsData = {
            unifiedLoggingSurface = UnifiedLoggingSurface.CUSTOMIZE
        }
    }
end

if FFlagAXGifting then
    tbl2[AvatarScreen.SendGiftRecipientPicker] = { isTransparent = true, VRPanelPlacement = "Left" }

    tbl2[AvatarScreen.SendGiftReview] = { isTransparent = true, VRPanelPlacement = "Left" }
end

if FFlagEditProfileImageV2Enabled then
    tbl2[AvatarScreen.EditProfileImage] = { isTryOnOutfitResetPage = true }

    tbl2[AvatarScreen.AppCatalogContextMenuHost] = { isTransparent = true }
end

if FFlagAXPhotoboothMomentsPage then
    tbl2[AvatarScreen.PhotoboothMomentsPage] = {
        isTryOnOutfitResetPage = true,
        analyticsData = FFlagAXPhotoboothMomentsLogging and {
            unifiedLoggingSurface = UnifiedLoggingSurface.PHOTOBOOTH_MOMENTS
        } or nil
    }
end

local tbl3 = ({})

for _, value in AvatarScreen do
    tbl3[value] = Cryo.Dictionary.join(tbl1, tbl2[value] or {})
end

return tbl3
