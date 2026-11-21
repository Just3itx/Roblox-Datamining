-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfile = script:FindFirstAncestor("EditProfile")
local EditProfileParent = EditProfile.Parent
local React = require(EditProfileParent.React)
local ReactRoblox = require(EditProfileParent.ReactRoblox)
local Display = require(EditProfileParent.Display)
local _Enums = require(EditProfile.Common.Enums)
local Cryo = require(EditProfileParent.Cryo)
local Foundation = require(EditProfileParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local GetDisplayStore = Display.GetDisplayStore
local useEditProfileScreenConfig = require(EditProfile.Hooks.useEditProfileScreenConfig)
local EditProfileModal = require(EditProfile.BaseComponents.EditProfileModal)
local EditProfileScreen = require(EditProfile.BaseComponents.EditProfileScreen)
local FocusNavigatorWrapper = require(EditProfile.Utils.FocusNavigatorWrapper)
local FFlagAXEnableProfileTab = require(EditProfileParent.SharedFlags).FFlagAXEnableProfileTab
local FFlagSplitPaneFullBleedEditProfile = require(EditProfileParent.SharedFlags).FFlagSplitPaneFullBleedEditProfile

local function EditorSlot(tbl1)
    local ref = React.useRef(nil)

    React.useLayoutEffect(function()
        local host = tbl1.host
        host.Parent = ref.current
        return function()
            host.Parent = nil
        end
    end, { tbl1.host })

    return React.createElement(View, { tag = "size-full-0 auto-y", ref = ref })
end

local function createEditorHost(): Frame
    local editorHost = Instance.new("Frame")
    editorHost.Name = "EditorHost"
    editorHost.BackgroundTransparency = 1
    editorHost.BorderSizePixel = 0
    editorHost.Size = UDim2.fromScale(1, 0)
    editorHost.AutomaticSize = Enum.AutomaticSize.Y
    return editorHost
end

return function(tbl1)
    local params = tbl1.navigation.state.params
    local var1 = useEditProfileScreenConfig(params.screen)
    local displayStore = GetDisplayStore(false)
    local var2 = useTokens()

    local textBoxRef = React.useRef(nil)
    local var4 = React.useRef(false)

    React.useEffect(function()
        if textBoxRef.current and textBoxRef.current.focus and not var4.current then
            var4.current = true
            textBoxRef.current.focus()
        end
    end, { textBoxRef.current })

    local var5 = React.useMemo(function()
        local tbl2 = {
            registerSaveHandler = var1.registerSaveHandler,
            textBoxRef = textBoxRef
        }
        if var1.updateErrorState then
            tbl2.updateErrorState = var1.updateErrorState
        end
        return (React.createElement(var1.component, tbl2))
    end, { var1.component, var1.registerSaveHandler, textBoxRef })

    local bool1 = FFlagAXEnableProfileTab and tbl1.navigation.state.params.fullBleed == true
    local element, portal

    if FFlagSplitPaneFullBleedEditProfile then
        local var6 = React.useContext(require(EditProfileParent.SplitPane).PaneHostContext)
        if var6 ~= nil then
            bool1 = not var6.isFullScreen
        end
        local host = React.useMemo(createEditorHost, {})
        React.useEffect(function()
            return function()
                host:Destroy()
            end
        end, { host })
        element = React.createElement(EditorSlot, { host = host })
        portal = ReactRoblox.createPortal(var5, host)
    else
        element = var5
        portal = nil
    end

    local join = Cryo.Dictionary.join
    local tbl2 = { component = 0, isDisabled = 0, fullBleed = 0 }
    if FFlagSplitPaneFullBleedEditProfile then
        var5 = element
    end

    tbl2.component = var5
    tbl2.isDisabled = var1.hasError == true

    tbl2.fullBleed = bool1
    local var6 = join(var1, tbl2)

    local bool2 = displayStore.getDisplaySize(false) == Enum.DisplaySize.Small
    local content = if bool2 or bool1 then React.createElement(EditProfileScreen, var6) else React.createElement(EditProfileModal, var6)

    if bool1 then
        local var7 = FocusNavigatorWrapper
        local tbl3 = {
            onClose = var1.onClose
        }
        local tbl4 = { Content = content, Editor = 0 }
        if not FFlagSplitPaneFullBleedEditProfile then
            portal = nil
        end

        tbl4.Editor = portal
        return var7(tbl3, tbl4)
    end

    local var7 = FocusNavigatorWrapper
    local tbl3 = {
        onClose = var1.onClose
    }
    local tbl4 = {
        [1] = nil,
        (React.createElement("ImageButton", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = var2.Color.Common.Scrim.Transparency,
            BackgroundColor3 = var2.Color.Common.Scrim.Color3,
            Active = true,
            AutoButtonColor = false,
            [React.Event.Activated] = if bool2 then nil else var1.onClose
        }, { Content = content }))
    }

    if not FFlagSplitPaneFullBleedEditProfile then
        portal = nil
    end

    tbl4.Editor = portal
    return var7(tbl3, tbl4)
end
