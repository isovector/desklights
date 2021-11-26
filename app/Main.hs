module Main where

import System.IO
import System.Environment
import System.Hardware.Serialport
import Data.Word
import Data.Char (chr)

scale :: RealFrac a => a -> a -> a -> (Int, Int, Int)
scale r g b = if a == 0 then (0,0,0) else (floor r', floor g', floor b')
  where
    a=r+g+b
    s=80/a
    r'=s*r
    g'=s*g
    b'=s*b

setDeskColor :: RealFrac a => a -> a -> a -> IO ()
setDeskColor r g b = do
  let (r', g', b') = scale r g b
  hWithSerial "/dev/ttyUSB0" defaultSerialSettings $ \h -> do
    hPutChar h $ chr r'
    hPutChar h $ chr g'
    hPutChar h $ chr b'


main :: IO ()
main = do
  [r, g, b] <- fmap read <$> getArgs
  setDeskColor r g b
