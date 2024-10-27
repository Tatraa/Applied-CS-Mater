-- main.lua
local love = require("love")

local grid = {}
local currentPiece
local nextPiece
local pieceX, pieceY
local pieceRotation
local gameOver

local pieces = {
    {{1, 1, 1, 1}}, -- I
    {{1, 1, 1}, {0, 1, 0}}, -- T
    {{1, 1, 0}, {0, 1, 1}}, -- S
    {{0, 1, 1}, {1, 1, 0}}, -- Z
    {{1, 1}, {1, 1}} -- O
}

local colors = {
    {0, 1, 1},
    {1, 0, 1},
    {0, 1, 0},
    {1, 0, 0},
    {1, 1, 0}
}

local function newPiece()
    local index = love.math.random(#pieces)
    currentPiece = pieces[index]
    pieceX = 4
    pieceY = 0
    pieceRotation = 1
end

local function rotatePiece()
    local newPiece = {}
    for y = 1, #currentPiece[1] do
        newPiece[y] = {}
        for x = 1, #currentPiece do
            newPiece[y][x] = currentPiece[#currentPiece - x + 1][y]
        end
    end
    currentPiece = newPiece
end

local function canPlacePiece(px, py, piece)
    for y = 1, #piece do
        for x = 1, #piece[y] do
            if piece[y][x] == 1 then
                local gx, gy = px + x, py + y
                if gx < 1 or gx > 10 or gy > 20 or (gy > 0 and grid[gy][gx] ~= 0) then
                    return false
                end
            end
        end
    end
    return true
end

local function placePiece()
    for y = 1, #currentPiece do
        for x = 1, #currentPiece[y] do
            if currentPiece[y][x] == 1 then
                grid[pieceY + y][pieceX + x] = 1
            end
        end
    end
end

local function clearLines()
    for y = 20, 1, -1 do
        local full = true
        for x = 1, 10 do
            if grid[y][x] == 0 then
                full = false
                break
            end
        end
        if full then
            table.remove(grid, y)
            table.insert(grid, 1, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
        end
    end
end

function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Tetris")
    for y = 1, 20 do
        grid[y] = {}
        for x = 1, 10 do
            grid[y][x] = 0
        end
    end
    newPiece()
    gameOver = false
end

function love.draw()
    for y = 1, 20 do
        for x = 1, 10 do
            if grid[y][x] == 1 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", (x - 1) * 30, (y - 1) * 30, 30, 30)
            end
        end
    end
    for y = 1, #currentPiece do
        for x = 1, #currentPiece[y] do
            if currentPiece[y][x] == 1 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", (pieceX + x - 1) * 30, (pieceY + y - 1) * 30, 30, 30)
            end
        end
    end
end

function love.update(dt)
    if gameOver then return end
    pieceY = pieceY + 1
    if not canPlacePiece(pieceX, pieceY, currentPiece) then
        pieceY = pieceY - 1
        placePiece()
        clearLines()
        newPiece()
        if not canPlacePiece(pieceX, pieceY, currentPiece) then
            gameOver = true
        end
    end
end

function love.keypressed(key)
    if key == "left" then
        if canPlacePiece(pieceX - 1, pieceY, currentPiece) then
            pieceX = pieceX - 1
        end
    elseif key == "right" then
        if canPlacePiece(pieceX + 1, pieceY, currentPiece) then
            pieceX = pieceX + 1
        end
    elseif key == "down" then
        if canPlacePiece(pieceX, pieceY + 1, currentPiece) then
            pieceY = pieceY + 1
        end
    elseif key == "up" then
        rotatePiece()
        if not canPlacePiece(pieceX, pieceY, currentPiece) then
            rotatePiece()
            rotatePiece()
            rotatePiece()
        end
    end
end

local json = require("json") -- Użyjemy modułu JSON do zapisu i odczytu stanu gry

function saveGame()
    local gameState = {
        grid = grid,
        currentPiece = currentPiece,
        pieceX = pieceX,
        pieceY = pieceY,
        pieceRotation = pieceRotation,
        gameOver = gameOver
    }
    local gameStateString = json.encode(gameState)
    love.filesystem.write("savegame.json", gameStateString)
end

function loadGame()
    if love.filesystem.getInfo("savegame.json") then
        local gameStateString = love.filesystem.read("savegame.json")
        local gameState = json.decode(gameStateString)
        grid = gameState.grid
        currentPiece = gameState.currentPiece
        pieceX = gameState.pieceX
        pieceY = gameState.pieceY
        pieceRotation = gameState.pieceRotation
        gameOver = gameState.gameOver
    end
end

local sounds = {
    move = love.audio.newSource("move.wav", "static"),
    rotate = love.audio.newSource("rotate.wav", "static"),
    line = love.audio.newSource("line.wav", "static"),
    gameOver = love.audio.newSource("gameover.wav", "static")
}

function playSound(action)
    if sounds[action] then
        sounds[action]:play()
    end
end

function playAnimation()
    -- Przykładowa animacja przy zbijaniu linii
    -- Można dodać bardziej zaawansowane animacje
    for y = 1, 20 do
        for x = 1, 10 do
            if grid[y][x] == 1 then
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", (x - 1) * 30, (y - 1) * 30, 30, 30)
            end
        end
    end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    local gridX = math.floor(x / 30) + 1
    local gridY = math.floor(y / 30) + 1

    if gridX < pieceX then
        if canPlacePiece(pieceX - 1, pieceY, currentPiece) then
            pieceX = pieceX - 1
        end
    elseif gridX > pieceX then
        if canPlacePiece(pieceX + 1, pieceY, currentPiece) then
            pieceX = pieceX + 1
        end
    elseif gridY > pieceY then
        if canPlacePiece(pieceX, pieceY + 1, currentPiece) then
            pieceY = pieceY + 1
        end
    else
        rotatePiece()
        if not canPlacePiece(pieceX, pieceY, currentPiece) then
            rotatePiece()
            rotatePiece()
            rotatePiece()
        end
    end
end