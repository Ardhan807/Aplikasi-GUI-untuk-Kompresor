from PyQt5.QtCore import * 
from PyQt5.QtGui import * 
from PyQt5.QtQml import * 
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *
import sys


class PressureControl(QObject):
    pressureChanged = pyqtSignal(float, arguments=['pressure'])

    def __init__(self):
        super().__init__()
        self._pressure = 0.0  # Tekanan awal dalam PSI
        self.target_pressure = 0.0
        self.timer = QTimer()
        self.timer.timeout.connect(self.updatePressure)

    @pyqtSlot(float)
    def setTargetPressure(self, pressure):
        """Mengatur nilai target tekanan dan memulai animasi."""
        self.target_pressure = pressure
        self.timer.start(50)  # Interval animasi 50ms
    @pyqtSlot()
    def resetPressure(self):
        """Mengatur tekanan ke nol dan memulai animasi."""
        self.setTargetPressure(0.0)

    def updatePressure(self):
        """Memperbarui nilai tekanan secara perlahan menuju target."""
        if abs(self._pressure - self.target_pressure) < 0.5:
            self._pressure = self.target_pressure
            self.timer.stop()  # Berhenti jika nilai tercapai
        else:
            self._pressure += 1.0 if self._pressure < self.target_pressure else -1.0
        self.pressureChanged.emit(self._pressure)
        print(f"Tekanan saat ini: {self._pressure:.2f} PSI")
 
    @pyqtSlot(result=float)
    def getPressure(self):
        """Mengembalikan nilai tekanan saat ini."""
        return self._pressure


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Membuat instance backend
    pressureControl = PressureControl()

    # Menyediakan backend ke QML
    engine.rootContext().setContextProperty("pressureControl", pressureControl)

    # Memuat file QML
    engine.load(QUrl("main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())