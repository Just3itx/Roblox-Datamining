-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local AppComposition = require(BuildExperienceParent.AppComposition)
local Promise = require(BuildExperienceParent.Promise)
local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization
local LocalizationStrings = require(BuildExperience.LocalizationStrings)

local useCompositionLayout = AppComposition.useCompositionLayout

local ScrollView = Foundation.ScrollView
local View = Foundation.View

local SignalsReact = require(BuildExperienceParent.SignalsReact)

local getGameMediaStore = require(BuildExperienceParent.DataHydration).Game.getGameMediaStore
local UniverseConfiguration = require(BuildExperienceParent.DataHydration.UniverseConfiguration)

local createGalleryCaptureSource = require(BuildExperienceParent.Moments.createGalleryCaptureSource)

local useTokens = Foundation.Hooks.useTokens
local getGameMediaForUniverse = require(BuildExperience.utils.getGameMediaForUniverse)
local useMediaUpdater = require(BuildExperience.utils.useMediaUpdater)

local uploadCaptureAsync = require(BuildExperience.utils.uploadCaptureAsync)
local getThumbnailUrlAsync = require(BuildExperience.utils.getThumbnailUrlAsync)
local createImageAssetAsync = require(BuildExperience.utils.createImageAssetAsync)

local CaptureSelectionView = require(script.Parent.CaptureSelectionView)
local FilmstripSlot = require(script.Parent.FilmstripSlot)
local MediaPreview = require(script.Parent.MediaPreview)
local _types = require(script.Parent.types)

local FFlagMediaSelectorErrorLogging = require(BuildExperience.Flags.FFlagMediaSelectorErrorLogging)

local formatError = require(BuildExperience.utils.formatError)
local Snackbar = Foundation.Snackbar

local function IconThumbnailsEditor(tbl1)
    local var1 = useCompositionLayout()
    local var2 = useLocalization({
        captureLibrary = LocalizationStrings.MEDIA_SELECTION_CAPTURE_LIBRARY,
        delete = LocalizationStrings.MEDIA_SELECTION_DELETE
    })
    local var3 = if FFlagMediaSelectorErrorLogging then useLocalization({ mediaError = "Feature.Moments.Label.Error" }) else nil
    local captureLibrary = var2.captureLibrary
    local delete = var2.delete
    local gameMediaForUniverse = getGameMediaForUniverse(tbl1.universeId)
    local var4 = React.useMemo(function()
        return UniverseConfiguration.getUniverseConfigurationStore().getAndFetchSummary(tbl1.universeId)
    end, { tbl1.universeId })
    local var5 = SignalsReact.useSignalState(var4.data)
    local var6 = if var5 then tostring(var5.rootPlaceId) else nil
    local var7 = useTokens()
    local var8, var9 = React.useState(gameMediaForUniverse.icon)
    local current, var11 = React.useState(gameMediaForUniverse.thumbnails)
    local var12, var13 = React.useState({ kind = "icon" })
    local var14, var15 = React.useState(false)
    local var16, var17 = React.useState(nil)
    local var18, var19 = React.useState("editor")
    local var20, var21 = React.useState(nil)
    local var22, var23 = React.useState({})
    local title, var25 = React.useState("")
    local var26 = React.useRef(0)
    local var27 = React.useRef(false)
    local var28 = React.useRef(#gameMediaForUniverse.thumbnails + 1)

    local var29 = React.useRef(nil)
    if var29.current == nil then
        var29.current = createGalleryCaptureSource(nil, nil, { Enum.CaptureType.Screenshot })
    end

    local var30 = React.useRef(current)
    var30.current = current
    React.useRef(var8).current = var8

    local var31 = useMediaUpdater()

    React.useEffect(function()
        if var26.current ~= 0 then
            return
        end

        var11(gameMediaForUniverse.thumbnails)
    end, { gameMediaForUniverse.thumbnails })

    React.useEffect(function()
        if var26.current == 0 then
            var9(gameMediaForUniverse.icon)
        end
    end, { gameMediaForUniverse.icon })

    local var32 = React.useMemo(function()
        local result = {}
        for _, value in current do
            table.insert(result, value)
        end
        return result
    end, { current })

    local bool1 = var6 ~= nil
    local bool2 = #var32 < 10 and bool1
    local id = if var32[1] then var32[1].id else nil

    local var33 = React.useCallback(function(str1: string, bool3: boolean)
        var23(function(arg1)
            local var33 = table.clone(arg1)
            var33[str1] = if bool3 then true else nil
            return var33
        end)
    end, {})

    local var34 = React.useCallback(function()
        local var34 = var26
        var34.current += 1
    end, {})

    local var35 = React.useCallback(function()
        local var35 = var26
        var35.current = math.max(0, var26.current - 1)
    end, {})

    local onClose = React.useCallback(function()
        var25("")
    end, {})

    local var37 = React.useCallback(function(str1: string)
        local items = {}
        if bool1 then
            table.insert(items, { id = "capture_library", text = captureLibrary, icon = "icons/common/image" })
        end

        if str1 ~= "icon" and str1 ~= id and str1 ~= "empty" then
            table.insert(items, { id = "delete", text = delete, icon = "icons/common/trash" })
        end

        return {{ items = items }}
    end, {
        bool1,
        captureLibrary,
        delete,
        id
    })
    local var38 = React.useCallback(function(str1: string)
        if var22[str1] or var27.current and str1 ~= "icon" and str1 ~= "empty" then
            return
        end
        var17(str1)
        var15(true)
    end, { var22 })

    local onMenuActivated = React.useCallback(function(str1: string)
        var15(false)
        if var27.current and var16 ~= "icon" and var16 ~= "empty" then
            return
        end

        if str1 == "capture_library" and bool1 then
            var21(var16)
            var19("captureSelection")
            return
        end

        if str1 ~= "delete" then
            return
        end

        local var39 = var16
        if var39 == nil or var6 == nil or var22[var39] then
            return
        end

        local var40 = nil
        local var41 = nil
        for value, value2 in current do
            if value2.id == var39 then
                var40 = value
                var41 = value2
                break
            end
        end

        if var40 == nil or var41 == nil then
            return
        end

        if not var41.assetResourceName then
            return
        end
        local assetResourceName = var41.assetResourceName
        var27.current = true
        var34()
        var33(var39, true)
        var11(function(arg1)
            local result = {}
            for _, value in arg1 do
                if value.id ~= var39 then
                    table.insert(result, value)
                end
            end
            return result
        end)
        if var12.kind == "thumbnail" and var12.id == var39 then
            var13({ kind = "icon" })
        end

        var31.removePreview(var6, assetResourceName):andThen(function()
            getGameMediaStore().fetchGameMedia(tostring(tbl1.universeId))
        end):catch(function(arg1)
            if FFlagMediaSelectorErrorLogging then
                warn(`[BuildExperience] MediaSelector delete failed: {formatError(arg1)}`)
                var25(var3.mediaError)
            end
            var11(function(arg2)
                for _, value in arg2 do
                    if value.id == var39 then
                        return arg2
                    end
                end
                local var42 = table.clone(arg2)
                table.insert(var42, math.min(var40, #var42 + 1), var41)
                return var42
            end)
        end):finally(function()
            var27.current = false
            var33(var39, false)
            var35()
        end)
    end, {
        var16,
        var12,
        current,
        var31,
        var6,
        bool1,
        var22,
        var34,
        var35,
        var33,
        var3,
        tbl1.universeId
    })

    local onMenuClose = React.useCallback(function()
        var15(false)
    end, {})

    local onSelect = React.useCallback(function()
        var13({ kind = "icon" })
    end, {})

    local var42 = React.useCallback(function(str1: string)
        var13({ kind = "thumbnail", id = str1 })
    end, {})

    local var43 = React.useCallback(function()
        var38("icon")
    end, { var38 })

    local var44 = React.useCallback(function()
        var38("empty")
    end, { var38 })

    local var45 = React.useCallback(function(arg1)
        var38(arg1)
    end, { var38 })

    local onCaptureConfirmed = React.useCallback(function(arg1)
        local var46 = var20
        if var46 == nil or var6 == nil or var22[var46] then
            return
        end

        var19("editor")
        var21(nil)

        local var47 = nil
        local var48 = nil
        if var46 ~= "icon" and var46 ~= "empty" then
            for value, value2 in var30.current do
                if value2.id == var46 then
                    var48 = value2
                    var47 = value
                    break
                end
            end

            if var47 == nil or var48 == nil then
                return
            end
            if not var48.assetResourceName then
                return
            end
        end

        local var49

        if var46 == "empty" then
            var49 = `thumbnail_pending_{var28.current}`
            local var50 = var28
            var50.current += 1
        else
            var49 = var46
        end

        var34()
        var33(var49, true)

        if var46 == "icon" then
            var13({ kind = "icon" })
        elseif var46 == "empty" then
            var11(function(arg2)
                local var50 = table.clone(arg2)
                table.insert(var50, { id = var49, mediaType = "image", assetSource = nil })

                return var50
            end)
            var13({ kind = "thumbnail", id = var49 })
        else
            var11(function(arg2)
                local var50 = table.clone(arg2)
                for value, value2 in var50 do
                    if value2.id ~= var46 then
                        continue
                    end

                    var50[value] = {
                        id = value2.id,
                        mediaType = "image",
                        assetSource = nil
                    }

                    return var50
                end

                return var50
            end)
        end

        local var50 = uploadCaptureAsync(arg1):andThen(function(arg2)
            return getThumbnailUrlAsync(arg2.assetId)
        end):andThen(function(arg2)
            if typeof(arg2) == "table" and arg2.status == "in_review" then
                return Promise.reject({ code = "IN_REVIEW", message = "Capture is under moderation review" })
            end

            local imageUrl = arg2.imageUrl
            local var50 = var5 and {
                creatorType = var5.creatorType,
                creatorTargetId = var5.creatorTargetId
            } or nil

            return createImageAssetAsync(imageUrl, nil, var46 == "icon", var50):andThen(function(arg3)
                return {
                    imageAssetId = tostring(arg3.assetId),
                    displayUrl = imageUrl
                }
            end)
        end)

        local var51 = var50:andThen(function(arg2)
            return arg2.imageAssetId
        end)

        local var52 = if var46 == "icon" then var31.setIcon(var6, var51) elseif var46 == "empty" then var31.addPreview(var6, var51) else var31.replacePreview(var6, var51, var48.assetResourceName)

        var52:andThen(function()
            return var50
        end):andThen(function(tbl2)
            if var46 == "icon" then
                var9(tbl2.displayUrl)
            else
                local imageAssetId = tbl2.imageAssetId
                var11(function(arg2)
                    local var53 = table.clone(arg2)
                    for value, value2 in var53 do
                        if value2.id ~= var49 then
                            continue
                        end

                        var53[value] = {
                            id = imageAssetId,
                            mediaType = "image",
                            assetSource = tbl2.displayUrl,
                            assetResourceName = `assets/{tbl2.imageAssetId}`
                        }
                        return var53
                    end

                    return var53
                end)
                var13(function(arg2)
                    return if arg2.kind == "thumbnail" and arg2.id == var49 then {
                        kind = "thumbnail",
                        id = imageAssetId
                    } else arg2
                end)
            end
            getGameMediaStore().fetchGameMedia(tostring(tbl1.universeId))
        end):catch(function(arg2)
            if FFlagMediaSelectorErrorLogging then
                warn(`[BuildExperience] MediaSelector upload failed: {formatError(arg2)}`)
                var25(var3.mediaError)
            end
            if var46 == "icon" then
                return
            end
            if var46 ~= "empty" then
                local var53 = var48
                var11(function(arg3)
                    local var54 = table.clone(arg3)
                    for value, value2 in var54 do
                        if value2.id == var49 then
                            var54[value] = var53
                            return var54
                        end
                    end
                    return var54
                end)

                return
            end

            var11(function(arg3)
                local result = {}
                for _, value in arg3 do
                    if value.id ~= var49 then
                        table.insert(result, value)
                    end
                end
                return result
            end)
            var13(function(arg3)
                return if arg3.kind == "thumbnail" and arg3.id == var49 then { kind = "icon" } else arg3
            end)
        end):finally(function()
            var33(var49, false)
            var35()
        end)
    end, {
        var20,
        var31,
        var6,
        var5,
        var22,
        var34,
        var35,
        var33,
        var3,
        tbl1.universeId
    })

    local var47 = React.useCallback(function()
        var19("editor")
        var21(nil)
    end, {})

    React.useEffect(function()
        local backHandlerRef = tbl1.backHandlerRef
        if backHandlerRef then
            backHandlerRef.current = if var18 == "captureSelection" then var47 else nil
        end
        return function()
            if backHandlerRef then
                backHandlerRef.current = nil
            end
        end
    end, { var18, var47, tbl1.backHandlerRef })

    local var48 = React.useMemo(function()
        if var16 then
            return var37(var16)
        end

        return {{
            items = {}
        }}
    end, { var16, var37 })

    if var18 == "captureSelection" then
        return (React.createElement(CaptureSelectionView, { captureSource = var29.current, onCaptureConfirmed = onCaptureConfirmed }))
    end

    local mediaType = nil
    local assetSource = nil
    local bool3 = false
    local bool4 = false

    if var12.kind == "icon" then
        bool4 = var22.icon or false
        assetSource = var8
        mediaType = "image"
        bool3 = true
    elseif var12.kind == "thumbnail" then
        for _, value in var32 do
            if value.id == var12.id then
                mediaType = value.mediaType
                assetSource = value.assetSource
                bool4 = var22[value.id] or false
                break
            end
        end
    end

    local tbl2 = ({})

    local isMenuOpen = var14 and var16 == "icon"
    local createElement = React.createElement
    local var50 = FilmstripSlot
    local tbl3 = {
        aspectRatio = "square",
        mediaType = "image",
        assetSource = var8,
        isFilled = true,
        isSelected = var12.kind == "icon",
        isLoading = var22.icon or false,
        isMenuOpen = isMenuOpen,
        menuItems = if isMenuOpen then var48 else nil,
        onMenuActivated = onMenuActivated,
        onMenuClose = onMenuClose,
        onSelect = onSelect,
        onEditPressed = 0,
        LayoutOrder = 1
    }

    if not bool1 then
        var43 = nil
    end

    tbl3.onEditPressed = var43
    tbl2.IconSlot = createElement(var50, tbl3)

    for value, value2 in var32 do
        local id2 = value2.id
        local isSelected = var12.kind == "thumbnail" and var12.id == id2
        local var10 = var14 and var16 == id2

        local createElement2 = React.createElement
        local var52 = FilmstripSlot
        local tbl4 = {
            aspectRatio = "wide",
            mediaType = value2.mediaType,
            assetSource = value2.assetSource,
            isFilled = true,
            isSelected = isSelected,
            isLoading = var22[id2] or false,
            isMenuOpen = var10,
            menuItems = if var10 then var48 else nil,
            onMenuActivated = onMenuActivated,
            onMenuClose = onMenuClose,
            onSelect = 0,
            onEditPressed = 0,
            LayoutOrder = 0
        }

        function tbl4.onSelect()
            var42(id2)
        end
        tbl4.onEditPressed = bool1 and function()
            var45(id2)
        end or id2 ~= id and function()
            var45(id2)
        end or nil

        tbl4.LayoutOrder = value + 1
        tbl2[id2] = createElement2(var52, tbl4)
    end

    if bool2 then
        local var10 = var14 and var16 == "empty"
        local createElement2 = React.createElement
        local var52 = FilmstripSlot
        local tbl4 = {
            aspectRatio = "wide",
            mediaType = nil,
            assetSource = nil,
            isFilled = false,
            isSelected = false,
            isMenuOpen = var10,
            menuItems = 0,
            onMenuActivated = 0,
            onMenuClose = 0,
            onSelect = 0,
            onEmptySlotPressed = 0,
            LayoutOrder = 0
        }

        if not var10 then
            var48 = nil
        end

        tbl4.menuItems = var48
        tbl4.onMenuActivated = onMenuActivated
        tbl4.onMenuClose = onMenuClose
        tbl4.onSelect = var44
        tbl4.onEmptySlotPressed = var44
        tbl4.LayoutOrder = #var32 + 2
        tbl2.EmptySlot = createElement2(var52, tbl4)
    end

    return React.createElement(View, { tag = "col gap-xlarge size-full" }, {
        ErrorSnackbar = if FFlagMediaSelectorErrorLogging and title ~= "" then React.createElement(
            View,
            { tag = "row align-x-center size-full-0 auto-y padding-x-large", LayoutOrder = 0 },
            {
                Snackbar = React.createElement(Snackbar, { title = title, onClose = onClose, testId = "MediaSelector.error-snackbar" })
            }
        ) else nil,
        Preview = React.createElement(View, {
            tag = {
                ["align-x-center align-y-center fill size-full-0"] = true,
                ["composition-content-body padding-y-xxlarge"] = true
            },
            LayoutOrder = 1,
            testId = "MediaSelector.Preview"
        }, {
            PreviewContent = React.createElement(
                MediaPreview,
                {
                    mediaType = mediaType,
                    assetSource = assetSource,
                    isIcon = bool3,
                    isLoading = bool4
                }
            )
        }),
        Filmstrip = React.createElement(ScrollView, {
            tag = "size-full-0 auto-y",
            padding = {
                top = UDim.new(0, var7.Padding.XXLarge),
                bottom = UDim.new(0, var7.Padding.XXLarge),
                left = UDim.new(0, var1.margin),
                right = UDim.new(0, var1.margin)
            },
            LayoutOrder = 2,
            testId = "MediaSelector.Filmstrip",
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, var7.Gap.Medium)
            },
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2.new(0, 0, 1, 0),
                ScrollingDirection = Enum.ScrollingDirection.X,
                scrollBarVisibility = Foundation.Enums.Visibility.None
            }
        }, tbl2)
    })
end

return IconThumbnailsEditor
