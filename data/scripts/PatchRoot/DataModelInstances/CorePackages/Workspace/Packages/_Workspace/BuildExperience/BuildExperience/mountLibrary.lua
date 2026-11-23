-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")

local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local LinkingProtocol = require(BuildExperienceParent.LinkingProtocol)
local DeepLinkSource = LinkingProtocol.Enums.DeepLinkSource
local default = LinkingProtocol.LinkingProtocol.default
local React = require(BuildExperienceParent.React)
local ReactFocusNavigation = require(BuildExperienceParent.ReactFocusNavigation)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)
local RoactNavigation = require(BuildExperienceParent.RoactNavigation)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local Signals = require(BuildExperienceParent.Signals)
local RobloxAppLocales = require(BuildExperienceParent.RobloxAppLocales)

local BuildExperienceCompositionStyleSheet = require(BuildExperience.Components.BuildExperienceCompositionStyleSheet)
local LibraryThemeProvider = require(BuildExperience.Components.Library.LibraryThemeProvider)
local LibraryLeavingOverlay = require(BuildExperience.Components.Library.LibraryLeavingOverlay)
local _LibraryDetailContainer = require(BuildExperience.Components.Library.LibraryDetail.LibraryDetailContainer)
local LibraryExperienceView = require(BuildExperience.Components.Library.LibraryExperienceView)
local LibraryNavigator = require(BuildExperience.Components.Library.LibraryNavigator)

local useLibraryWorldCutoutViewModel = require(BuildExperience.Components.Library.LibraryWorldCutout.useLibraryWorldCutoutViewModel)
local getAndroidBackSignal = require(BuildExperience.utils.getAndroidBackSignal)
local bindLibraryBackInput = require(BuildExperience.utils.bindLibraryBackInput)
local leaveExperience = require(BuildExperience.utils.leaveExperience)
local FocusNavigationUtils = require(BuildExperienceParent.FocusNavigationUtils)
local _LibraryCategories = require(BuildExperience.Components.Library.LibraryCategories)
local createBuildLibraryStore = require(BuildExperience.Stores.BuildLibrary.createBuildLibraryStore)
local useLibraryStrings = require(BuildExperience.Components.Library.useLibraryStrings)
local GetLibraryStore = require(BuildExperience.Stores.GetLibraryStore)
local GetPlayButtonStore = require(BuildExperience.Stores.GetPlayButtonStore)
local sendBuildExperienceEvent = require(BuildExperience.Telemetry.sendBuildExperienceEvent)
local createViewerWorldPicker = require(BuildExperience.createViewerWorldPicker)
local getDefaultWorldFocus = require(BuildExperience.Components.Library.LibraryWorldCutout.getDefaultWorldFocus)
local getModelBox = require(BuildExperience.Components.Library.LibraryWorldCutout.getModelBox)
local FIntBuildExperienceLibrarySelectAllMax = require(BuildExperience.Flags.FIntBuildExperienceLibrarySelectAllMax)
local getLibraryMatches = require(BuildExperience.Components.Library.getLibraryMatches)
local LocalizationProvider = Localization.LocalizationProvider
local Localization2 = RobloxAppLocales.Localization
local LibraryTypes = require(BuildExperience.Components.Library.LibraryTypes)
local _chatTypes = require(BuildExperience.Chat.chatTypes)
local FFlagBuildExperienceLibrary = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceLibrary
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)

local tbl1 = ({})
local var1 = nil

local function requestModelFocus(arg1, tbl2) -- Luacid: Inlined by compiler; 4 call sites recovered
    local var2, var3 = arg1:GetBoundingBox()
    tbl2.requestFocus(var2.Position, var3.Magnitude / 2, arg1)
end

local function outlineModel(path: string, adornee)
    local var2 = tbl1[path]
    if var2 ~= nil then
        var2:Destroy()
    end
    local buildLibraryFocusHighlight = Instance.new("Highlight")
    buildLibraryFocusHighlight.Name = "BuildLibraryFocusHighlight"
    buildLibraryFocusHighlight.DepthMode = Enum.HighlightDepthMode.Occluded
    buildLibraryFocusHighlight.OutlineColor = Color3.fromRGB(0, 200, 255)
    buildLibraryFocusHighlight.FillColor = Color3.fromRGB(0, 170, 255)
    buildLibraryFocusHighlight.FillTransparency = 0.75
    buildLibraryFocusHighlight.Adornee = adornee
    buildLibraryFocusHighlight.Parent = CoreGui
    tbl1[path] = buildLibraryFocusHighlight
end

local function removeOutline(path: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = tbl1[path]
    if var2 ~= nil then
        var2:Destroy()
        tbl1[path] = nil
    end
end

local function clearOutlines() -- Luacid: Inlined by compiler; 4 call sites recovered
    for _, value in tbl1 do
        value:Destroy()
    end
    table.clear(tbl1)
end

local function requestModelsFocus(tbl2, tbl3)
    local minimum = nil
    local maximum = nil
    for _, value in tbl2 do
        local modelBox = getModelBox(value)
        if modelBox == nil then
            continue
        end

        if minimum == nil then
            minimum = modelBox.minimum
        else
            minimum = minimum:Min(modelBox.minimum)
        end

        if maximum == nil then
            maximum = modelBox.maximum
        else
            maximum = maximum:Max(modelBox.maximum)
        end
    end
    if minimum ~= nil and maximum ~= nil then
        tbl3.requestFocus((minimum + maximum) / 2, (maximum - minimum).Magnitude / 2)
    end
end

local function requestWorldFocus(tbl2, tbl3, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local defaultWorldFocus = getDefaultWorldFocus(tbl2, arg1)
    if defaultWorldFocus ~= nil then
        tbl3.requestFocus(defaultWorldFocus.position, defaultWorldFocus.radius)
    end
end

local function limitSelectAll(tbl2, tbl3)
    local num1 = math.max(1, FIntBuildExperienceLibrarySelectAllMax)
    if #tbl2 <= num1 then
        return tbl2, tbl3.selectAll
    end
    local var2 = string.gsub(tbl3.selectFirst, "{count}", tostring(num1))
    return table.move(tbl2, 1, num1, 1, {}), var2
end

local function getWorkspace(dataModel): Workspace? -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return dataModel:GetService("Workspace")
    end)
    return if success and typeof(result) == "Instance" and result:IsA("Workspace") then result else nil
end

local function ConnectedLibrary(tbl2)
    local libraryStore = GetLibraryStore()
    local var2 = React.useRef(os.clock())
    local var3 = React.useRef(false)
    local var4 = React.useCallback(function()
        return {
            universeId = tbl2.dataModel.GameId,
            placeId = tbl2.dataModel.PlaceId,
            conversationId = tbl2.eventSessionId
        }
    end, { tbl2.dataModel, tbl2.eventSessionId })

    local var5 = React.useRef({})
    local function getSelectionPaths(path: string?)
        local selectionPaths = {}
        for _, value in var5.current do
            if value.path ~= path then
                table.insert(selectionPaths, value.path)
            end
        end
        return selectionPaths
    end
    local function deselect(path: string)
        local current = {}
        for _, value in var5.current do
            if value.path ~= path then
                table.insert(current, value)
            end
        end
        var5.current = current
        removeOutline(path)
    end

    local var6 = useLibraryStrings()
    local var7 = libraryStore.useIsOpen()
    local var8 = SignalsReact.useSignalState(libraryStore.getChatComposerState)
    local onAddResource = if var8 == nil then nil else var8.onAddResource
    local onRemoveResourceByPath = if var8 == nil then nil else var8.onRemoveResourceByPath

    local resourceActions = React.useMemo(function(): {onAddResource: (any) -> any, onRemoveResource: (any) -> ()} | {onAddResource: (any) -> boolean, onRemoveResource: any}
        return if onAddResource == nil or onRemoveResourceByPath == nil then {
            onAddResource = function(arg1): boolean
                libraryStore.requestAddToChat(arg1)
                return true
            end,
            onRemoveResource = libraryStore.requestRemoveFromChat
        } else {
            onAddResource = function(arg1)
                for _, value in (getSelectionPaths(arg1.path)) do
                    deselect(value)
                    onRemoveResourceByPath(value)
                end
                return onAddResource(arg1)
            end,
            onRemoveResource = function(arg1)
                onRemoveResourceByPath(arg1.path)
            end
        }
    end, { onAddResource or false, onRemoveResourceByPath or false, libraryStore })

    local var10, var11 = React.useState({ routeName = "Browser" })
    local itemId = if var10.routeName == "Detail" then var10.params.itemId else nil
    local kind = if itemId == nil then "Model" else var10.params.itemKind
    local params = if var10.routeName == "Category" or var10.routeName == "Search" and var10.params.itemKind ~= nil then var10.params else nil

    local var13 = React.useMemo(function()
        return getWorkspace(tbl2.dataModel)
    end, { tbl2.dataModel })
    local var14 = SignalsReact.useSignalState(tbl2.library.getItems)

    local var15 = React.useMemo(function()
        local result = {}
        if var13 == nil then
            return result
        end
        local Players = tbl2.dataModel:GetService("Players")
        for _, value in var14 do
            local model = value.model
            if model ~= nil and model:IsDescendantOf(var13) and Players:GetPlayerFromCharacter(model) == nil then
                table.insert(result, model)
            end
        end
        return result
    end, { var13, var14, tbl2.dataModel })
    local isAvailable = #var15 > 0
    local var16 = useLibraryWorldCutoutViewModel({
        isAvailable = isAvailable,
        isHome = var10.routeName == "Browser",
        isOpen = var7,
        onViewportRectChanged = libraryStore.setWorldViewportRect
    })
    local useEffect = React.useEffect
    local function func1()
        local item = if itemId == nil then nil else tbl2.library.getItem(false, itemId)
        local var17 = sendBuildExperienceEvent
        local str1 = "LIBRARY_IMPRESSION"
        local var18 = var4()
        local tbl3 = {
            phase = "viewed",
            surface = if var7 then var10.routeName else "World",
            kind = if itemId ~= nil then kind elseif params == nil then "All" else params.itemKind,
            scope = if params == nil or params.folderId == nil then "Root" else "Folder",
            hasDescription = if item == nil then nil else tostring(item.description ~= nil),
            location = if item == nil then nil else item.rootName
        }
        var17(str1, var18, tbl3)
    end

    local library = tbl2.library

    local routeName = var10.routeName
    local var17 = itemId or false
    local var18 = not (params == nil) and (params.folderId or params.itemKind)
    useEffect(func1, { library, var4, var7, routeName, var17, kind, var18 })

    local var19 = React.useRef(nil)
    local externalDispatchConnector = React.useCallback(function(current)
        var19.current = current
        return function()
            var19.current = nil
        end
    end, {})
    local onNavigationStateChange = React.useCallback(function(_, arg1)
        var11(arg1.routes[arg1.index])
    end, {})
    local var22, var23 = React.useState("")
    local var24 = React.useRef(nil)
    local var25 = React.useCallback(function(str1: string)
        var23(str1)
        local current = var19.current
        if current ~= nil then
            local reducedMotion = UserSettings():GetService("UserGameSettings").ReducedMotion
            if str1 ~= "" and var10.routeName ~= "Search" then
                current(
                    RoactNavigation.Actions.navigate(
                        {
                            routeName = "Search",
                            key = "LibrarySearch",
                            params = params or {},
                            immediate = reducedMotion
                        }
                    )
                )
            elseif str1 == "" and var10.routeName == "Search" then
                current(RoactNavigation.StackActions.pop({ immediate = reducedMotion }))
            end
        end
        if var24.current ~= nil then
            task.cancel(var24.current)
        end
        var24.current = task.delay(0.3, function()
            var24.current = nil
            sendBuildExperienceEvent("LIBRARY_SEARCH", var4(), {
                surface = if params == nil then "Browser" else "Category",
                kind = if params == nil then "All" else params.itemKind,
                scope = if params == nil or params.folderId == nil then "Root" else "Folder",
                hasQuery = tostring(str1 ~= "")
            })
        end)
    end, { var4, var10, params or false })
    React.useEffect(function()
        return function()
            if var24.current ~= nil then
                task.cancel(var24.current)
                var24.current = nil
            end
        end
    end, { itemId or false, not (params == nil) and params.itemKind, not (params == nil) and (params.folderId or false) })

    local var26 = React.useCallback(function()
        var25("")
    end, { var25 })
    local library2 = tbl2.library
    local isReady, var28 = React.useState(false)
    local var29 = React.useCallback(function()
        local success, result = pcall(function()
            library2.refresh()
            return nil
        end)
        if success then
            return
        end

        sendBuildExperienceEvent(
            "LIBRARY_FETCH_FAILED",
            var4(),
            {
                surface = "Library",
                phase = if var3.current then "refresh" else "initial",
                reason = "refresh_failed"
            }
        )
        error(result, 0)
    end, { library2, var4 })
    React.useEffect(function()
        sendBuildExperienceEvent("LIBRARY_IMPRESSION", var4(), { phase = "opened", surface = "Library" })
        local dataModel = tbl2.dataModel
        local function ready()
            var29()
            var28(true)
            if var3.current then
                return
            end

            var3.current = true
            local tbl3 = { Model = 0, Image = 0, Sound = 0, Folder = 0 }
            for _, value in library2.getItems(false) do
                local var30 = if value.className == "Folder" then "Folder" else value.kind
                tbl3[var30] += 1
            end
            sendBuildExperienceEvent("LIBRARY_IMPRESSION", var4(), {
                phase = "ready",
                surface = "Library",
                durationMs = tostring(math.round((os.clock() - var2.current) * 1000)),
                modelCount = tostring(tbl3.Model),
                imageCount = tostring(tbl3.Image),
                soundCount = tostring(tbl3.Sound),
                folderEntryCount = tostring(tbl3.Folder)
            })
        end

        local connection = dataModel.Loaded:Connect(ready)
        local connection2 = dataModel:GetService("Workspace").PersistentLoaded:Connect(ready)
        if dataModel:IsLoaded() then
            ready()
        end
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, {
        library2,
        tbl2.dataModel,
        var29,
        var4
    })

    local var30 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if itemId == nil then
                return nil
            end
            return library2.getItem(arg1, itemId)
        end)
    end, { library2, itemId or false })
    local var31 = SignalsReact.useSignalState(var30)

    local onBack = React.useCallback(function()
        local current = var19.current
        if var10.routeName == "Browser" or current == nil then
            libraryStore.setIsOpen(false)

            return
        end

        if var10.routeName == "Search" then
            var23("")
        else
            var29()
        end
        libraryStore.setIsOpen(true)
        GetPlayButtonStore().setIsActive(false)
        current(
            RoactNavigation.StackActions.pop(
                {
                    immediate = var10.routeName == "Search" and UserSettings():GetService("UserGameSettings").ReducedMotion
                }
            )
        )
    end, { var10.routeName, libraryStore, var29 })

    local onOpenCategory = React.useCallback(function(arg1, categoryKey, title: string, folderId: string?)
        var29()
        if folderId ~= nil then
            var23("")
        end
        local current = var19.current
        if current == nil then
            return
        end

        sendBuildExperienceEvent(
            "LIBRARY_CATEGORY_CLICK",
            var4(),
            {
                action = if folderId == nil then "category" else "folder",
                kind = arg1,
                surface = var10.routeName
            }
        )
        current(
            RoactNavigation.Actions.navigate({
                routeName = "Category",
                key = if folderId == nil then "LibraryCategory" else `LibraryFolder:{folderId}`,
                params = {
                    itemKind = arg1,
                    categoryKey = categoryKey,
                    title = title,
                    folderId = folderId
                }
            })
        )
    end, { var29, var4, var10.routeName })

    local onOpenItem = React.useCallback(function(itemId2: string, arg1)
        local current = var19.current
        if current == nil then
            return
        end

        local item = library2.getItem(false, itemId2)
        sendBuildExperienceEvent("LIBRARY_ASSET_CLICK", var4(), {
            action = "detail",
            kind = arg1,
            surface = if libraryStore.getIsOpen(false) then var10.routeName else "World",
            location = if item == nil then nil else item.rootName
        })
        current(
            RoactNavigation.Actions.navigate(
                {
                    routeName = "Detail",
                    key = "LibraryDetail",
                    params = { itemId = itemId2, itemKind = arg1 }
                }
            )
        )
    end, {
        var4,
        var10.routeName,
        libraryStore,
        library2
    })
    local var35 = React.useRef(false)
    local var36 = React.useRef(nil)
    React.useEffect(function()
        if var35.current or var13 == nil then
            return
        end

        if not var7 or var16.phase ~= "Home" then
            var35.current = true
            return
        end

        if not (isReady and var16.isMeasured) then
            return
        end

        if FFlagBuildExperienceLibrary then
            if isAvailable then
                var35.current = true
                requestWorldFocus(var15, libraryStore, var13)
            end

            return
        end

        for _, value in var14 do
            local model = value.model

            if value.folderId == nil and value.className ~= "Folder" and model ~= nil and model:IsDescendantOf(var13) then
                var35.current = true
                var36.current = model
                requestModelFocus(model, libraryStore)
                return
            end
        end
    end, {
        var14,
        isReady,
        var7,
        var16.phase,
        var16.isMeasured,
        var13,
        libraryStore,
        isAvailable,
        var15
    })

    local current = var7 and var10.routeName == "Browser"
    local var38 = React.useRef(current)
    React.useEffect(function()
        if FFlagBuildExperienceLibrary then
            if current and not var38.current and var35.current and isAvailable then
                requestWorldFocus(var15, libraryStore, var13)
            end
            var38.current = current
            return
        end
        local current2 = var36.current
        local focusRequest = libraryStore.getFocusRequest(false)

        if current
            and not var38.current
            and current2 ~= nil
            and var13 ~= nil
            and current2:IsDescendantOf(var13)
            and (focusRequest == nil or focusRequest.model ~= current2)
        then
            requestModelFocus(current2, libraryStore)
        end
        var38.current = current
    end, {
        current,
        var13,
        libraryStore,
        isAvailable,
        var15
    })
    local var39 = React.useRef("Browser")
    var39.current = if var7 then var10.routeName else "World"
    local var40 = React.useRef(false)
    local var9 = React.useCallback(function(reason: string)
        if var40.current then
            return
        end
        var40.current = true
        sendBuildExperienceEvent("LIBRARY_IMPRESSION", var4(), { phase = "closed", reason = reason, surface = var39.current })
    end, { var4 })
    local var42 = React.useRef(var9)
    var42.current = var9
    React.useEffect(function()
        return function()
            var42.current("other")
        end
    end, {})

    React.useEffect(function()
        game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()
        return function()
            tbl2.onUnmount()
            clearOutlines()
        end
    end, { tbl2.onUnmount })

    local var43, var44 = React.useState(false)
    local var45 = React.useRef(false)

    local var46, var47 = React.useState(false)
    React.useEffect(function()
        local connection = RunService.RenderStepped:Once(function()
            var47(true)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})
    React.useEffect(function()
        if current then
            clearOutlines()
        end
    end, { current })

    local var48 = React.useRef(0)
    React.useEffect(function()
        if var31 == nil or var31.model == nil then
            return
        end

        local bool2 = true
        local connection = var31.model.Destroying:Connect(function()
            local var49 = var48
            var49.current += 1
            libraryStore.clearFocus()
            local var50 = LibraryTypes.toChatResource(var31)
            deselect(var50.path)
            resourceActions.onRemoveResource(var50)
            task.defer(function()
                if bool2 then
                    var29()
                end
            end)
        end)
        return function()
            bool2 = false
            connection:Disconnect()
        end
    end, {
        var31 or false,
        libraryStore,
        resourceActions,
        var29
    })

    local var49 = SignalsReact.useSignalState(GetPlayButtonStore().getIsActive)
    local bool1 = not (var8 == nil) and var8.isAssistantResponding == true
    local var50 = React.useRef(false)
    local var51 = React.useRef(nil)
    local var52 = SignalsReact.useSignalState(libraryStore.getPromptFailure)
    local var53 = React.useRef(if var52 == nil then 0 else var52.token)
    React.useEffect(function()
        if var52 == nil or var52.token <= var53.current then
            return
        end
        var53.current = var52.token
        local current = var51.current
        if current == nil then
            return
        end
        var51.current = nil
        local var54 = table.clone(current)
        var54.phase = "failed"
        if var52.errorCode ~= nil then
            var54.errorCode = tostring(var52.errorCode)
        end
        sendBuildExperienceEvent("LIBRARY_ASSET_CLICK", var4(), var54)
    end, { var52, var4 })
    React.useEffect(function()
        if var50.current and not bool1 then
            var51.current = nil
        end
        if var50.current and not bool1 and isReady and var7 then
            var29()
        end
        var50.current = bool1
    end, {
        bool1,
        isReady,
        var7,
        var29
    })

    local var54 = React.useRef(onRemoveResourceByPath)
    var54.current = onRemoveResourceByPath
    local function removeFromChat(tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
        local current = var54.current
        if current ~= nil then
            for _, value in tbl3 do
                current(value.path)
            end

            return
        end

        libraryStore.requestRemoveAllFromChat(tbl3)
    end

    local var55 = React.useRef({})
    local function unwatchSelection() -- Luacid: Inlined by compiler; 2 call sites recovered
        for _, value in var55.current do
            value:Disconnect()
        end
        var55.current = {}
    end
    local function watchSelection(tbl3)
        unwatchSelection()
        local tbl4 = {}
        for _, value in tbl3 do
            local model = value.model
            if model == nil then
                continue
            end

            local var56 = LibraryTypes.toChatResource(value)

            local current = var55.current
            local destroying = model.Destroying

            table.insert(current, destroying:Connect(function()
                if #tbl4 == 0 then
                    task.defer(function()
                        local var57 = tbl4
                        tbl4 = {}
                        removeFromChat(var57)
                        var29()
                    end)
                end
                table.insert(tbl4, var56)
                deselect(var56.path)
            end))
        end
    end

    React.useEffect(function()
        return unwatchSelection
    end, {})
    local var56 = React.useCallback(function(tbl3, bool3: boolean)
        clearOutlines()
        local tbl4 = {}
        for _, value in tbl3 do
            if value.model ~= nil then
                outlineModel(LibraryTypes.toChatResource(value).path, value.model)
                table.insert(tbl4, value.model)
            end
        end
        if #tbl3 == 1 and #tbl4 == 1 then
            requestModelFocus(tbl4[1], libraryStore)
        elseif #tbl4 > 0 then
            requestModelsFocus(tbl4, libraryStore)
        end
        libraryStore.setIsOpen(false)
        local var56 = var48
        var56.current += 1
        local current = var48.current
        task.defer(function()
            if var48.current ~= current or libraryStore.getIsOpen(false) then
                return
            end
            local tbl5 = {}
            for _, value in tbl3 do
                table.insert(tbl5, LibraryTypes.toChatResource(value))
            end
            libraryStore.requestAddAllToChat(tbl5, getSelectionPaths(), bool3)
            var5.current = tbl5
            if FFlagBuildExperienceLibrary then
                watchSelection(tbl3)
            end
            GetPlayButtonStore().setIsActive(true)
        end)
    end, { libraryStore })
    local var57 = React.useCallback(function(arg1, bool3: boolean)
        if arg1.model ~= nil and not arg1.model:IsDescendantOf(workspace) then
            return
        end
        var56({ arg1 }, bool3)
    end, { var56 })
    React.useEffect(function()
        return function()
            local var58 = var48
            var58.current += 1
        end
    end, {})

    local var58 = SignalsReact.useSignalState(libraryStore.getChipEvent)
    React.useEffect(function()
        if var58 == nil then
            return
        end
        local tbl3 = {}
        for _, value in var5.current do
            if table.find(var58.uris, LibraryTypes.toResourceUri(value.path)) then
                table.insert(tbl3, value)
            end
        end
        if #tbl3 == 0 then
            return
        end

        if var58.kind == "Removed" then
            for _, value in tbl3 do
                deselect(value.path)
            end

            return
        end
        if var58.kind ~= "Activated" then
            libraryStore.requestAddAllToChat(tbl3, {}, false)
            return
        end

        local tbl4 = {}
        for _, value in var5.current do
            tbl4[value.path] = true
        end
        for _, value in library2.getItems(false) do
            if not tbl4[value.path] or value.model == nil or not value.model:IsDescendantOf(workspace) then
                continue
            end

            outlineModel(value.path, value.model)
            if value.path == tbl3[1].path then
                requestModelFocus(value.model, libraryStore)
            end
        end
    end, { var58, libraryStore, library2.getItems })
    React.useEffect(function()
        if var7 or not (isReady and isAvailable) then
            return nil
        end
        local Workspace = tbl2.dataModel:GetService("Workspace")
        local currentCamera = Workspace.CurrentCamera
        if currentCamera == nil then
            return nil
        end
        local bool3 = true
        local viewerWorldPicker = createViewerWorldPicker({
            camera = currentCamera,
            userInputService = tbl2.dataModel:GetService("UserInputService"),
            world = Workspace,
            isBlocked = function()
                return not bool3 or libraryStore.getIsOpen(false)
            end,
            onPick = function(arg1)
                local var59 = library2.resolveWorldItem(arg1)
                if var59 == nil then
                    var29()
                    var59 = library2.resolveWorldItem(arg1)
                end
                if var59 ~= nil then
                    onOpenItem(var59.id, var59.kind)
                    var57(var59, not GetPlayButtonStore().getIsActive(false))
                end
            end,
            onMiss = function()
                local current = var5.current
                if #current == 0 then
                    return
                end
                var5.current = {}
                unwatchSelection()
                clearOutlines()
                removeFromChat(current)
            end
        })

        return function()
            bool3 = false
            viewerWorldPicker()
        end
    end, {
        var7,
        isReady,
        isAvailable,
        libraryStore,
        library2,
        var29,
        var57,
        onOpenItem,
        resourceActions,
        tbl2.dataModel
    })

    local function onShowLibrary()
        if isReady then
            var29()
        end
        if not libraryStore.getIsOpen(false) then
            sendBuildExperienceEvent(
                "LIBRARY_ASSET_CLICK",
                var4(),
                var16.exit() and {
                    action = "back",
                    kind = "All",
                    surface = "World",
                    source = "home_cutout"
                }
                    or FFlagBuildExperienceLibrary
                        and itemId == nil
                        and {
                            action = "back",
                            kind = "Model",
                            surface = "World",
                            source = "select_all"
                        }
                    or { action = "object", kind = kind, surface = "World" }
            )
        end
        local var59 = var48
        var59.current += 1
        GetPlayButtonStore().setIsActive(false)
        libraryStore.setIsOpen(true)
    end
    local onWorldViewportChanged = React.useCallback(function(arg1)
        libraryStore.setWorldViewportRect(
            if arg1 == nil then nil else Rect.new(arg1.AbsolutePosition, arg1.AbsolutePosition + arg1.AbsoluteSize)
        )
    end, { libraryStore })
    local function onShowWorld(source: string?)
        if itemId ~= nil then
            local item = library2.getItem(false, itemId)
            if item ~= nil then
                local isOpen = libraryStore.getIsOpen(false)
                var57(item, source ~= "prompt")
                local var60 = isOpen and not libraryStore.getIsOpen(false)
                if var60 or isOpen and item.model ~= nil and not item.model:IsDescendantOf(workspace) then
                    sendBuildExperienceEvent("LIBRARY_ASSET_CLICK", var4(), {
                        action = "world",
                        outcome = if var60 then nil else "unavailable",
                        kind = item.kind,
                        surface = "Detail",
                        source = source or "segmented_control",
                        location = item.rootName
                    })
                end
                return
            end
        end
        libraryStore.setIsOpen(false)
    end
    local function onActivated()
        if var10.routeName ~= "Browser" or not (libraryStore.getIsOpen(false) and var16.enter()) then
            return
        end
        sendBuildExperienceEvent(
            "LIBRARY_ASSET_CLICK",
            var4(),
            { action = "world", kind = "All", surface = "Home", source = "home_cutout" }
        )

        if FFlagBuildExperienceLibrary then
            requestWorldFocus(var15, libraryStore, var13)
        end
        onShowWorld()
    end
    local function returnToAppChat(str1: string?, str2: string)
        if var45.current then
            return
        end
        var45.current = true
        var44(true)
        var9(str2)
        local input = str1 or tbl2.sessionId
        local str3 = `roblox://navigation/build?universeid={tbl2.dataModel.GameId}`
        if input ~= nil then
            str3 ..= `&sessionid={HttpService:UrlEncode(input)}`
        end
        if default:isInternalDlicEnabled() then
            local var60 = default:createInternalDlic(str3, DeepLinkSource.LuaInternal)
            task.spawn(leaveExperience, function()
                default:detectDeeplinkIntent(var60)
            end)
        else
            task.spawn(leaveExperience, function()
                default:detectURL(str3)
            end)
        end
    end
    local function onNavigateBack()
        if var45.current then
            return
        end

        if not var7 then
            onShowLibrary()
        elseif var10.routeName == "Browser" then
            returnToAppChat(nil, "back_button")
        else
            onBack()
        end
    end
    local var60 = React.useRef(onNavigateBack)
    var60.current = onNavigateBack
    local var61 = React.useRef(nil)
    React.useEffect(function()
        local function navigateBack()
            var60.current()
        end
        local connection = getAndroidBackSignal():Connect(navigateBack)
        local var12 = bindLibraryBackInput(navigateBack)
        var61.current = var12
        return function()
            connection:Disconnect()
            var12.unbind()
            var61.current = nil
        end
    end, {})
    React.useEffect(function()
        if var61.current ~= nil then
            var61.current.setChatOpen(var49)
        end
    end, { var49 })

    local chatActions = if var8 == nil then nil else table.clone(var8)

    if chatActions ~= nil and var8 ~= nil then
        local onSend = var8.onSend
        function chatActions.onSend()
            local tbl3 = {
                action = "prompt",
                kind = kind,
                surface = "Detail",
                location = if var31 == nil then nil else var31.rootName
            }
            local function onPromptAccepted() -- Luacid: Inlined by compiler; 1 call site recovered
                local var63 = table.clone(tbl3)
                var63.phase = "received"
                sendBuildExperienceEvent("LIBRARY_ASSET_CLICK", var4(), var63)
            end

            local var63 = if kind == "Image" or kind == "Sound" then onSend(function(str1: string?)
                onPromptAccepted()
                returnToAppChat(str1, "prompt_return")
            end) else onSend(onPromptAccepted)

            if var63 then
                var51.current = tbl3
            end
            if var63 and kind == "Model" then
                onShowWorld("prompt")
            end
            local var64 = table.clone(tbl3)
            var64.phase = "submit"
            var64.outcome = if var63 then "accepted" else "rejected"
            sendBuildExperienceEvent("LIBRARY_ASSET_CLICK", var4(), var64)
            return var63
        end
    end

    local bool3 = var10.routeName == "Category" or var10.routeName == "Search"
    local var63 = not bool3 and {} or var10.params or {}
    local var64 = if var10.routeName ~= "Search" then "" else var22
    local var65 = React.useMemo(function()
        local result = {}
        if not (FFlagBuildExperienceLibrary and bool3) then
            return result
        end
        if var63.itemKind ~= nil and var63.itemKind ~= "Model" then
            return result
        end
        local tbl3 = ({})
        for _, value in var15 do
            tbl3[value] = true
        end
        for _, value in getLibraryMatches(var14, "Model", var64, var63.folderId, true) do
            if value.model ~= nil and tbl3[value.model] then
                table.insert(result, value)
            end
        end
        return result
    end, {
        bool3,
        var63.itemKind or false,
        var63.folderId or false,
        var64,
        var14,
        var15
    })

    local var66, selectAllLabel = limitSelectAll(var65, var6)
    local function func5()
        sendBuildExperienceEvent("LIBRARY_ASSET_CLICK", var4(), {
            action = "select_all",
            kind = "Model",
            surface = var10.routeName,
            scope = if var63.folderId == nil then "Root" else "Folder",
            hasQuery = tostring(var64 ~= ""),
            selectedCount = tostring(#var66),
            matchCount = tostring(#var65)
        })
        var56(var66, true)
    end

    local element = React.createElement(LibraryNavigator, {
        externalDispatchConnector = externalDispatchConnector,
        onNavigationStateChange = onNavigationStateChange,
        screenProps = {
            library = library2,
            isReady = isReady,
            isOpen = var7,
            activeRouteKey = var10.key,
            query = var22,
            onBack = onBack,
            onOpenItem = onOpenItem,
            onOpenCategory = onOpenCategory,
            chatActions = chatActions,
            resourceActions = resourceActions,
            unavailableText = var6.modelUnavailable,
            worldCutout = (isAvailable or FFlagBuildExperienceLibrary and not isReady)
                and {
                    title = var6.world,
                    onActivated = onActivated,
                    onRectChanged = var16.onCellRectChanged
                }
                or nil
        }
    })
    local assetLabel = if itemId == nil then var6.title elseif kind == "Model" then var6.object elseif kind == "Image" then var6.image else var6.sound
    local createElement = React.createElement
    local focusRoot = FocusNavigationUtils.FocusRoot
    local tbl3 = {
        surfaceIdentifier = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = var7,
        isFocusable = var7,
        isIsolated = true
    }
    local tbl4 = { Experience = 0, Leaving = 0, FirstFrameCover = 0 }
    local createElement2 = React.createElement
    local var69 = LibraryExperienceView
    local tbl5 = {
        isOpen = var7,
        showModeControl = isAvailable and not (itemId == nil) and kind == "Model",
        isWorldAvailable = if var31 == nil or var31.model == nil then nil else var31.model:IsDescendantOf(workspace),
        title = if itemId ~= nil then if var31 == nil then assetLabel else var31.displayName elseif var16.phase == "Expanding" or var16.phase == "World" then var6.world elseif params ~= nil then params.title else var6.title,
        onBack = if FFlagBuildExperienceLibrary and not var7 and itemId == nil then onShowLibrary elseif itemId ~= nil or params ~= nil or var10.routeName == "Search" then onBack elseif var7 then nil else onShowLibrary,
        query = 0,
        searchPlaceholder = 0,
        onQueryChanged = 0,
        onSearchReset = 0,
        selectAllLabel = 0,
        onSelectAll = 0,
        assetLabel = 0,
        worldLabel = 0,
        onShowLibrary = 0,
        onShowWorld = 0,
        onWorldViewportChanged = 0,
        worldCutout = 0,
        onLeave = 0
    }

    if itemId ~= nil then
        var22 = nil
    end

    tbl5.query = var22
    tbl5.searchPlaceholder = var6.searchPlaceholder
    tbl5.onQueryChanged = if itemId == nil then var25 else nil
    if itemId ~= nil then
        var26 = nil
    end

    tbl5.onSearchReset = var26
    tbl5.selectAllLabel = selectAllLabel
    if not (#var65 > 0) then
        func5 = nil
    end

    tbl5.onSelectAll = func5
    tbl5.assetLabel = assetLabel
    tbl5.worldLabel = var6.world
    tbl5.onShowLibrary = onShowLibrary
    tbl5.onShowWorld = onShowWorld
    tbl5.onWorldViewportChanged = onWorldViewportChanged
    tbl5.worldCutout = var16.view
    function tbl5.onLeave()
        returnToAppChat(nil, "close_button")
    end

    tbl4.Experience = createElement2(var69, tbl5, element)

    tbl4.Leaving = if var43 then React.createElement(LibraryLeavingOverlay, { ZIndex = 2 }) else nil
    tbl4.FirstFrameCover = if var46 then nil else React.createElement(Foundation.View, { ZIndex = 3, tag = "size-full bg-surface-0", testId = "Library.FirstFrameCover" })
    return createElement(focusRoot, tbl3, tbl4)
end

local function mountLibrary(dataModel, sessionId: string?)
    if var1 ~= nil then
        return var1
    end
    GetLibraryStore().setIsOpen(true)

    local buildExperienceLibrary = Instance.new("ScreenGui")
    buildExperienceLibrary.Name = "BuildExperienceLibrary"
    buildExperienceLibrary.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    buildExperienceLibrary.ClipToDeviceSafeArea = false
    buildExperienceLibrary.ResetOnSpawn = false
    buildExperienceLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    buildExperienceLibrary.DisplayOrder = 10
    buildExperienceLibrary.Parent = CoreGui

    local library = createBuildLibraryStore(dataModel or game)
    local root = ReactRoblox.createRoot(buildExperienceLibrary)
    var1 = root
    local localization2 = Localization2.new(LocalizationService.RobloxLocaleId)

    local focusNavigationService = ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui)

    ReactRoblox.flushSync(function()
        local var2 = root
        local createElement = React.createElement
        local var3 = LocalizationProvider
        local tbl2 = { localization = localization2 }
        local tbl3 = { FoundationProvider = 0 }
        local createElement2 = React.createElement
        local var4 = LibraryThemeProvider
        local tbl4 = { displayOrder = 10 }
        local tbl5 = {
            CompositionStyleSheet = React.createElement(BuildExperienceCompositionStyleSheet),
            Library = 0
        }
        local createElement3 = React.createElement
        local provider = ReactFocusNavigation.FocusNavigationContext.Provider
        local tbl6 = { value = focusNavigationService }
        local tbl7 = { Registry = 0 }
        local createElement4 = React.createElement
        local provider2 = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider
        local var5 = nil
        local tbl8 = { Content = 0 }
        local createElement5 = React.createElement
        local func1 = ConnectedLibrary
        local tbl9 = {
            dataModel = dataModel or game,
            library = library,
            sessionId = sessionId,
            eventSessionId = if FFlagBuildExperienceEventContextTelemetry then sessionId else nil,
            onUnmount = 0
        }

        function tbl9.onUnmount()
            focusNavigationService:teardown()
            var1 = nil
            buildExperienceLibrary:Destroy()
        end

        tbl8.Content = createElement5(func1, tbl9)
        tbl7.Registry = createElement4(provider2, var5, tbl8)
        tbl5.Library = createElement3(provider, tbl6, tbl7)
        tbl3.FoundationProvider = createElement2(var4, tbl4, tbl5)
        var2:render(createElement(var3, tbl2, tbl3))
    end)

    return root
end

return mountLibrary
