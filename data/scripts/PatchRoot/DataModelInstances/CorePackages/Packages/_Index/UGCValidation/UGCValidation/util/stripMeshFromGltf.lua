-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local function stripMeshFromGltf(input: string): string
    local input2 = HttpService:JSONDecode(input)

    input2.meshes = nil
    input2.materials = nil
    input2.textures = nil
    input2.images = nil
    input2.skins = nil

    if input2.nodes then
        local nodes = {}
        local tbl2 = ({})
        local tbl3 = ({})

        for i, value in ipairs(input2.nodes) do
            if value.name and string.find(value.name, "_Geo$") then
                tbl3[i] = true
            end
        end

        local num1 = 0
        for i, value in ipairs(input2.nodes) do
            if tbl3[i] then
                continue
            end

            value.mesh = nil
            value.skin = nil

            if value.children then
                local tbl4 = {}
                for _, child in ipairs(value.children) do
                    if not tbl3[child + 1] then
                        table.insert(tbl4, child)
                    end
                end
                if not (#tbl4 > 0) then
                    tbl4 = nil
                end

                value.children = tbl4
            end
            table.insert(nodes, value)
            tbl2[i] = num1
            num1 += 1
        end

        for _, value in ipairs(nodes) do
            if not value.children then
                continue
            end

            for i, child in ipairs(value.children) do
                local var1 = child + 1
                if tbl2[var1] then
                    value.children[i] = tbl2[var1]
                end
            end
        end

        if input2.animations then
            for _, animation in ipairs(input2.animations) do
                if not animation.channels then
                    continue
                end

                for _, channel in ipairs(animation.channels) do
                    if not (channel.target and channel.target.node) then
                        continue
                    end

                    local var1 = channel.target.node + 1
                    if tbl2[var1] then
                        channel.target.node = tbl2[var1]
                    end
                end
            end
        end

        if input2.scenes then
            for _, value in ipairs(input2.scenes) do
                if not value.nodes then
                    continue
                end

                local tbl1 = {}
                for _, value2 in ipairs(value.nodes) do
                    local var1 = value2 + 1
                    if tbl2[var1] then
                        table.insert(tbl1, tbl2[var1])
                    end
                end
                value.nodes = tbl1
            end
        end

        input2.nodes = nodes
    end

    return HttpService:JSONEncode(input2)
end

return stripMeshFromGltf
