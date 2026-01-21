import { useState, useEffect, useRef, useCallback } from 'react'
import { Button } from '@/components/ui/button'
import { Card } from '@/components/ui/card'

type GameState = 'start' | 'playing' | 'gameOver'

interface Pipe {
  x: number
  topHeight: number
  passed: boolean
}

const BIRD_SIZE = 34
const PIPE_WIDTH = 60
const PIPE_GAP = 180
const GRAVITY = 0.6
const JUMP_STRENGTH = -10
const GAME_SPEED = 3

function App() {
  const [gameState, setGameState] = useState<GameState>('start')
  const [birdY, setBirdY] = useState(250)
  const [birdVelocity, setBirdVelocity] = useState(0)
  const [pipes, setPipes] = useState<Pipe[]>([])
  const [score, setScore] = useState(0)
  const [highScore, setHighScore] = useState(0)
  const canvasRef = useRef<HTMLCanvasElement>(null)
  const gameLoopRef = useRef<number | null>(null)

  const jump = useCallback(() => {
    if (gameState === 'start') {
      setGameState('playing')
      setBirdVelocity(JUMP_STRENGTH)
    } else if (gameState === 'playing') {
      setBirdVelocity(JUMP_STRENGTH)
    }
  }, [gameState])

  const resetGame = useCallback(() => {
    setBirdY(250)
    setBirdVelocity(0)
    setPipes([{ x: 600, topHeight: 150, passed: false }])
    setScore(0)
    setGameState('start')
  }, [])

  useEffect(() => {
    const handleKeyPress = (e: KeyboardEvent) => {
      if (e.code === 'Space' || e.code === 'ArrowUp') {
        e.preventDefault()
        if (gameState === 'gameOver') {
          resetGame()
        } else {
          jump()
        }
      }
    }

    window.addEventListener('keydown', handleKeyPress)
    return () => window.removeEventListener('keydown', handleKeyPress)
  }, [gameState, jump, resetGame])

  useEffect(() => {
    if (gameState !== 'playing') return

    const canvas = canvasRef.current
    if (!canvas) return

    const ctx = canvas.getContext('2d')
    if (!ctx) return

    const gameLoop = () => {
      // Update bird physics
      setBirdVelocity((v) => v + GRAVITY)
      setBirdY((y) => {
        const newY = y + birdVelocity
        // Check ground/ceiling collision
        if (newY > 550 - BIRD_SIZE || newY < 0) {
          setGameState('gameOver')
          if (score > highScore) setHighScore(score)
        }
        return newY
      })

      // Update pipes
      setPipes((currentPipes) => {
        let newPipes = currentPipes.map((pipe) => ({
          ...pipe,
          x: pipe.x - GAME_SPEED,
        }))

        // Add new pipe
        if (newPipes.length === 0 || newPipes[newPipes.length - 1].x < 400) {
          const topHeight = Math.random() * 200 + 100
          newPipes.push({ x: 600, topHeight, passed: false })
        }

        // Remove off-screen pipes
        newPipes = newPipes.filter((pipe) => pipe.x > -PIPE_WIDTH)

        // Check collisions and scoring
        newPipes.forEach((pipe) => {
          const birdX = 100
          const birdRight = birdX + BIRD_SIZE
          const birdBottom = birdY + BIRD_SIZE
          const pipeRight = pipe.x + PIPE_WIDTH

          // Check if bird passed pipe
          if (!pipe.passed && birdX > pipeRight) {
            pipe.passed = true
            setScore((s) => s + 1)
          }

          // Check collision
          if (birdRight > pipe.x && birdX < pipeRight) {
            if (birdY < pipe.topHeight || birdBottom > pipe.topHeight + PIPE_GAP) {
              setGameState('gameOver')
              if (score > highScore) setHighScore(score)
            }
          }
        })

        return newPipes
      })

      gameLoopRef.current = requestAnimationFrame(gameLoop)
    }

    gameLoopRef.current = requestAnimationFrame(gameLoop)

    return () => {
      if (gameLoopRef.current) {
        cancelAnimationFrame(gameLoopRef.current)
      }
    }
  }, [gameState, birdVelocity, birdY, score, highScore])

  useEffect(() => {
    const canvas = canvasRef.current
    if (!canvas) return

    const ctx = canvas.getContext('2d')
    if (!ctx) return

    // Clear canvas
    ctx.fillStyle = '#87CEEB'
    ctx.fillRect(0, 0, 600, 550)

    // Draw pipes
    pipes.forEach((pipe) => {
      ctx.fillStyle = '#228B22'
      // Top pipe
      ctx.fillRect(pipe.x, 0, PIPE_WIDTH, pipe.topHeight)
      // Bottom pipe
      ctx.fillRect(pipe.x, pipe.topHeight + PIPE_GAP, PIPE_WIDTH, 550 - pipe.topHeight - PIPE_GAP)
      
      // Pipe highlights
      ctx.fillStyle = '#32CD32'
      ctx.fillRect(pipe.x, 0, 8, pipe.topHeight)
      ctx.fillRect(pipe.x, pipe.topHeight + PIPE_GAP, 8, 550 - pipe.topHeight - PIPE_GAP)
    })

    // Draw bird
    ctx.fillStyle = '#FFD700'
    ctx.beginPath()
    ctx.arc(100 + BIRD_SIZE / 2, birdY + BIRD_SIZE / 2, BIRD_SIZE / 2, 0, Math.PI * 2)
    ctx.fill()
    
    // Bird eye
    ctx.fillStyle = '#000'
    ctx.beginPath()
    ctx.arc(100 + BIRD_SIZE / 2 + 8, birdY + BIRD_SIZE / 2 - 4, 4, 0, Math.PI * 2)
    ctx.fill()
    
    // Bird beak
    ctx.fillStyle = '#FF6347'
    ctx.beginPath()
    ctx.moveTo(100 + BIRD_SIZE, birdY + BIRD_SIZE / 2)
    ctx.lineTo(100 + BIRD_SIZE + 10, birdY + BIRD_SIZE / 2 - 4)
    ctx.lineTo(100 + BIRD_SIZE + 10, birdY + BIRD_SIZE / 2 + 4)
    ctx.closePath()
    ctx.fill()

    // Draw ground
    ctx.fillStyle = '#8B4513'
    ctx.fillRect(0, 550, 600, 50)
    ctx.fillStyle = '#A0522D'
    for (let i = 0; i < 600; i += 30) {
      ctx.fillRect(i, 550, 25, 50)
    }
  }, [birdY, pipes])

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-sky-300 via-blue-200 to-cyan-300">
      <Card className="p-8 shadow-2xl bg-white/95 backdrop-blur">
        <div className="text-center mb-4">
          <h1 className="text-4xl font-bold text-slate-800 mb-2">Flappy Bird</h1>
          <div className="flex justify-between text-lg font-semibold text-slate-700 mb-2">
            <span>Score: {score}</span>
            <span>High Score: {highScore}</span>
          </div>
        </div>

        <div className="relative">
          <canvas
            ref={canvasRef}
            width={600}
            height={600}
            className="border-4 border-slate-700 rounded-lg cursor-pointer"
            onClick={gameState === 'gameOver' ? resetGame : jump}
          />

          {gameState === 'start' && (
            <div className="absolute inset-0 flex items-center justify-center bg-black/40 rounded-lg">
              <div className="text-center bg-white p-8 rounded-xl shadow-xl">
                <h2 className="text-3xl font-bold mb-4 text-slate-800">Ready to Play?</h2>
                <p className="text-slate-600 mb-6">
                  Click, tap, or press Space/Arrow Up to jump!
                </p>
                <Button
                  onClick={jump}
                  size="lg"
                  className="bg-emerald-600 hover:bg-emerald-700 text-white font-bold"
                >
                  Start Game
                </Button>
              </div>
            </div>
          )}

          {gameState === 'gameOver' && (
            <div className="absolute inset-0 flex items-center justify-center bg-black/40 rounded-lg">
              <div className="text-center bg-white p-8 rounded-xl shadow-xl">
                <h2 className="text-3xl font-bold mb-4 text-red-600">Game Over!</h2>
                <p className="text-2xl mb-2 text-slate-700">Score: {score}</p>
                <p className="text-lg mb-6 text-slate-600">High Score: {highScore}</p>
                <Button
                  onClick={resetGame}
                  size="lg"
                  className="bg-blue-600 hover:bg-blue-700 text-white font-bold"
                >
                  Play Again
                </Button>
              </div>
            </div>
          )}
        </div>

        <div className="mt-4 text-center text-sm text-slate-600">
          <p>Controls: Click, Space, or Arrow Up to jump</p>
        </div>
      </Card>
    </div>
  )
}

export default App
