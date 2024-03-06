local testString = [[here's one
long string boiiiiii
iafafja]]
io.write(testString .. "\n")

local femboy = ""
local age = 21
-- 0 is true unlike in C
-- empty strings are true tho, like in C
if not femboy then
    io.write("the femboy is " .. "moon")
elseif age > 18 then
    io.write("certified femboy :3\n")
end

local testFunc = function()
  local stupid = 10
  return stupid
end

print(testFunc())
local colors = { "red", "green", "blue" }
print(#colors)
-- #table prints the length of the table
--
for i = 1, #colors do
  print(colors[i])
end
print("\n")

local testDict = {name = "moon", age = 99, hobbies = "none", index = "fuck"}
for index, value in pairs(testDict) do
   print(testDict[index])
   -- or
   -- print(value)
  -- print(index, value)
end
print(LUA_PATH)
