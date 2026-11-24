-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")
local _Types = require(InGameAssetReporting.Analysis.Types)

function extractAssetIdsFromInstance(arg1)
    local tbl1 = {
        Package = {},
        Model = {},
        Image = {},
        Mesh = {},
        Text = {},
        Video = {}
    }
    if arg1:IsA("PackageLink") and arg1.PackageId ~= "" and arg1.VersionNumber > 0 then
        table.insert(tbl1.Package, { id = arg1.PackageId, version = arg1.VersionNumber })
        return tbl1
    end
    if arg1:IsA("Model") and arg1.SourceAssetId > 0 then
        table.insert(tbl1.Model, tostring(arg1.SourceAssetId))
        return tbl1
    end

    if arg1:IsA("MeshPart") and arg1.MeshId ~= "" then
        table.insert(tbl1.Mesh, arg1.MeshId)
        if arg1.TextureID ~= "" then
            table.insert(tbl1.Image, arg1.TextureID)
            return tbl1
        end
    elseif (arg1.ClassName == "FileMesh" or arg1.ClassName == "SpecialMesh" and arg1.MeshType == Enum.MeshType.FileMesh)
        and arg1.MeshId ~= ""
    then
        table.insert(tbl1.Mesh, arg1.MeshId)
        if arg1.TextureId ~= "" then
            table.insert(tbl1.Image, arg1.TextureId)
            return tbl1
        end
    else
        if arg1:IsA("ImageLabel") and arg1.Image ~= "" then
            table.insert(tbl1.Image, arg1.Image)
            return tbl1
        end

        if arg1:IsA("ImageButton") then
            if arg1.Image ~= "" then
                table.insert(tbl1.Image, arg1.Image)
            end
            if arg1.HoverImage ~= "" then
                table.insert(tbl1.Image, arg1.HoverImage)
            end
            if arg1.PressedImage ~= "" then
                table.insert(tbl1.Image, arg1.PressedImage)
                return tbl1
            end
        else
            if arg1:IsA("Decal") and arg1.Texture ~= "" then
                table.insert(tbl1.Image, arg1.Texture)
                return tbl1
            end

            if arg1:IsA("SurfaceAppearance") and arg1.ColorMap ~= "" then
                table.insert(tbl1.Image, arg1.ColorMap)
                return tbl1
            end
            if arg1:IsA("TextLabel") and arg1.Text ~= "" and game:GetEngineFeature("ExperienceStateCaptureExperienceChatSupport") then
                table.insert(tbl1.Text, arg1.Text)
                return tbl1
            end
            if arg1:IsA("TextButton") and arg1.Text ~= "" and game:GetEngineFeature("ExperienceStateCaptureExperienceChatSupport") then
                table.insert(tbl1.Text, arg1.Text)
                return tbl1
            end

            if arg1:IsA("TextBox") and game:GetEngineFeature("ExperienceStateCaptureExperienceChatSupport") then
                if arg1.Text ~= "" then
                    table.insert(tbl1.Text, arg1.Text)
                    return tbl1
                end

                if arg1.PlaceholderText ~= "" then
                    table.insert(tbl1.Text, arg1.PlaceholderText)
                    return tbl1
                end
            else
                if not arg1:IsA("VideoFrame") then
                    return nil
                end

                if arg1.Video ~= "" then
                    table.insert(tbl1.Video, arg1.Video)
                    return tbl1
                end
            end
        end
    end

    return tbl1
end

return extractAssetIdsFromInstance
