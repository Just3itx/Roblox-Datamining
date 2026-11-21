-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EditProfileParent = script:FindFirstAncestor("EditProfile").Parent
local React = require(EditProfileParent.React)
local View = require(EditProfileParent.Foundation).View
local RoactUtils = require(EditProfileParent.RoactUtils)
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useSelectedTheme = RoactUtils.Hooks.useSelectedTheme
local useLocalUserId = require(EditProfileParent.RobloxAppHooks).useLocalUserId
local getDisplayBackgroundId = require(EditProfileParent.EditProfileBackground).BackgroundUtils.getDisplayBackgroundId

local oyster = Color3.fromRGB(185, 185, 185)
local ghostGrey = Color3.fromRGB(200, 200, 200)

local InsertService = game:GetService("InsertService")

local function EditProfileBackgroundViewport(tbl1)
    local ref = React.useRef(nil)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(nil)
    local var4 = useSelectedTheme()
    local var5 = useLocalUserId()

    local var6 = useSelector(function(arg1)
        if arg1.ProfilePlatform and arg1.ProfilePlatform.Profiles and var5 then
            local var6 = arg1.ProfilePlatform.Profiles.User[tostring(var5)]
            if var6 and var6.components and var6.components.ProfileBackground then
                return var6.components.ProfileBackground.assetId
            end
        end
        return -1
    end)

    React.useEffect(function()
        task.defer(function()
            if not var6 then
                return
            end

            local success, result = pcall(function(): Instance
                return InsertService:LoadAsset(getDisplayBackgroundId(var6, var4))
            end)

            if not success or not result then
                return
            end

            if var1.current then
                for _, child in pairs(var1.current:GetChildren()) do
                    child:Destroy()
                end
            end

            local backgroundModel = Instance.new("Model")
            backgroundModel.Name = "BackgroundModel"
            backgroundModel.Parent = var1.current

            for _, child in pairs(result:GetChildren()) do
                child.Parent = backgroundModel
            end

            backgroundModel:PivotTo(CFrame.new(0, 7, -4.5))
            result:Destroy()

            local current = ref.current
            if current then
                current.Ambient = oyster
                current.LightColor = ghostGrey
                current.LightDirection = Vector3.new(0, 0.2, 0.2)
            end
        end)
    end, { var6, var4 })

    React.useEffect(function()
        if ref.current and var2.current then
            ref.current.CurrentCamera = var2.current
        end
    end)

    return React.createElement(View, {
        Size = UDim2.new(1, 0, 0, tbl1.height)
    }, {
        Background = React.createElement("ViewportFrame", {
            Size = UDim2.fromScale(1, 1),
            ZIndex = 1,
            ref = ref,
            Ambient = oyster,
            LightColor = ghostGrey,
            BackgroundTransparency = 1
        }, {
            WorldModel = React.createElement("WorldModel", { ref = var1 }),
            Camera = React.createElement("Camera", {
                CameraType = Enum.CameraType.Scriptable,
                CFrame = CFrame.lookAt(Vector3.new(0, 7, 4), Vector3.new(0, 7, 10)),
                ref = var2
            })
        })
    })
end

return EditProfileBackgroundViewport
