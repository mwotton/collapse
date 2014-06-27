import           Control.Monad
import           System.IO

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering
  forever $ do
    getLine >> emptyStdin
    putStrLn "x"

emptyStdin :: IO ()
emptyStdin = do
  res <- hReady stdin
  when res $ getLine >> void emptyStdin
