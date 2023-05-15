local json = require("hs.json")

function PrintTable(tbl)
    if tbl == nil then
        print("table is nil")
        return
    end
    -- local str = json.encode(tbl)
    -- print(str)
    for k, v in pairs(tbl) do print(tostring(k) .. ": " .. tostring(v)) end
end

function pt(tbl) PrintTable(tbl) end
