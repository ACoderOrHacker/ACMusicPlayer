pragma Singleton
import QtMultimedia
import ACMusicPlayer

ACMediaPlayer {
    id: player
    audioOutput: AudioOutput {
        volume: 1.0
    }
}
