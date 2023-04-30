function PrintTable(tbl)
    if tbl == nil 
    then
        print("table is nil")
        return
    end
    for k, v in pairs(tbl) do print(k .. ": " .. tostring(v)) end
end