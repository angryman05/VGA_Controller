# FPGA VGA Controller (Nexys A7)

This project is a VHDL implementation of a VGA controller, developed as a university project for the Digital System Design course. The system renders geometric shapes on a VGA monitor and allows the user to manipulate the shape type, color, and screen position in real-time using the FPGA board's switches and buttons.

## 📝 Description

The system uses a **Digilent Nexys A7** FPGA to generate standard VGA timing signals (640x480 @ 60Hz). The internal logic allows switching between 4 distinct shapes and 4 colors. Additionally, the user can translate the shape across the screen on the X and Y axes.

The architecture is modular, consisting of:
* **Control Unit:** Handles user inputs and debouncing.
* **VGA Signal Generator:** Generates `h_sync` and `v_sync` timing signals.
* **Rendering Logic:** Determines if the current pixel falls within the selected shape boundaries.
* **Color ROM:** A Look-Up Table for RGB output values.

## ✨ Features

* **Resolution:** 640x480 pixels.
* **Shapes:** Square, Triangle, Circle, Rectangle.
* **Colors:** Red, Blue, Green, White.
* **Position Control:** 4-way movement (Up, Down, Left, Right).
* **Debouncing:** Dedicated logic to stabilize button inputs.
* **Visual Feedback:** LEDs light up corresponding to active switches.

## 🛠️ Hardware Requirements

* FPGA Development Board: **Digilent Nexys A7** (Artix-7).
* VGA Monitor.
* Standard VGA Cable.

## 🎛️ Controls & Pin Mapping

The project utilizes the `constraints.xdc` file to map controls to the Nexys A7 specific pins.

### Switches (Configuration)
| Switch | Function | Description |
| :--- | :--- | :--- |
| `SW[0]` | **Enable Movement** | Must be **ON** to move the shape via buttons. |
| `SW[1]` | **Color Bit 0** | Combined with SW[2] to select color. |
| `SW[2]` | **Color Bit 1** | Combined with SW[1] to select color. |
| `SW[3]` | **Shape Bit 0** | Combined with SW[4] to select shape. |
| `SW[4]` | **Shape Bit 1** | Combined with SW[3] to select shape. |
| `SW[5]` | **Video Enable** | Turns the display output ON/OFF. |

**Selection Tables:**

| SW[2:1] | Color |
| :--- | :--- |
| `00` | Red |
| `01` | Blue |
| `10` | Green |
| `11` | White |

| SW[4:3] | Shape |
| :--- | :--- |
| `00` | Square |
| `01` | Triangle |
| `10` | Circle |
| `11` | Rectangle |

### Buttons (Movement)
*Requires `SW[0]` to be ON.*

| Button | Physical Label | Function |
| :--- | :--- | :--- |
| `btn[0]` | **BTNL** | Move Left |
| `btn[1]` | **BTNR** | Move Right |
| `btn[2]` | **BTNU** | Move Up |
| `btn[3]` | **BTND** | Move Down |
| `btn[4]` | **BTNC** | Reset Position |

## 📂 File Structure

* `VGA_Shapes.vhd`: Top-Level file. Contains the clock divider, H/V counters, and shape drawing logic.
* `ROM_Color.vhd`: ROM memory for color decoding.
* `debouncer.vhd`: Module for debouncing button inputs.
* `constraints.xdc`: Physical constraints file for Nexys A7.

## 🚀 How to Run

1.  Open **Xilinx Vivado**.
2.  Create a new project targeting the **Nexys A7** board.
3.  Add the provided source files (`.vhd`) and the constraint file (`.xdc`).
4.  Run **Synthesis**, **Implementation**, and **Generate Bitstream**.
5.  Program the device via USB.
6.  Connect the VGA monitor to the board.

---
---

# Controler VGA pe FPGA (Nexys A7)

Acest proiect reprezintă implementarea unui controler VGA în limbajul VHDL, dezvoltat ca proiect universitar pentru cursul de Proiectarea Sistemelor Numerice. Sistemul randează forme geometrice pe un monitor VGA și permite utilizatorului să modifice forma, culoarea și poziția acestora în timp real folosind comutatoarele și butoanele plăcii FPGA.

## 📝 Descriere

Sistemul utilizează un FPGA **Digilent Nexys A7** pentru a genera semnalele de sincronizare VGA (640x480 @ 60Hz). Logica internă permite selecția între 4 forme geometrice distincte și 4 culori. De asemenea, utilizatorul poate muta forma pe ecran pe axele X și Y.

Arhitectura este modulară, fiind compusă din:
* **Unitate de Control:** Gestionează input-urile de la utilizator (butoane, switch-uri) și eliminarea zgomotului (debouncing).
* **Generator de Semnal VGA:** Generează semnalele `h_sync` și `v_sync`.
* **Logică de Randare:** Determină pixelii activi pentru forma selectată.
* **ROM Culori:** Un tabel de adevăr pentru valorile RGB.

## ✨ Funcționalități

* **Rezoluție:** 640x480 pixeli.
* **Forme disponibile:** Pătrat, Triunghi, Cerc, Dreptunghi.
* **Culori disponibile:** Roșu, Albastru, Verde, Alb.
* **Control Poziție:** Deplasare pe 4 direcții (Sus, Jos, Stânga, Dreapta).
* **Feedback Vizual:** LED-urile de pe placă indică starea switch-urilor active.

## 🛠️ Hardware Necesar

* Placă de dezvoltare FPGA: **Digilent Nexys A7** (Artix-7).
* Monitor cu intrare VGA.
* Cablu VGA standard.

## 🎛️ Mapare Controale

Proiectul folosește fișierul `constraints.xdc` pentru a mapa logica pe pinii fizici ai plăcii Nexys A7.

### Switch-uri (Configurare)
| Switch | Funcție | Detalii |
| :--- | :--- | :--- |
| `SW[0]` | **Enable Movement** | Trebuie să fie **ON** pentru a muta forma din butoane. |
| `SW[1]` | **Culoare Bit 0** | Combinat cu SW[2] selectează culoarea. |
| `SW[2]` | **Culoare Bit 1** | Combinat cu SW[1] selectează culoarea. |
| `SW[3]` | **Formă Bit 0** | Combinat cu SW[4] selectează forma. |
| `SW[4]` | **Formă Bit 1** | Combinat cu SW[3] selectează forma. |
| `SW[5]` | **Video Enable** | Pornește/Oprește afișarea pe monitor. |

**Tabele de Selecție:**

| SW[2:1] | Culoare |
| :--- | :--- |
| `00` | Roșu |
| `01` | Albastru |
| `10` | Verde |
| `11` | Alb |

| SW[4:3] | Formă |
| :--- | :--- |
| `00` | Pătrat |
| `01` | Triunghi |
| `10` | Cerc |
| `11` | Dreptunghi |

### Butoane (Mișcare)
*Funcționează doar dacă `SW[0]` este ON.*

| Buton | Etichetă Placă | Acțiune |
| :--- | :--- | :--- |
| `btn[0]` | **BTNL** | Mută Stânga |
| `btn[1]` | **BTNR** | Mută Dreapta |
| `btn[2]` | **BTNU** | Mută Sus |
| `btn[3]` | **BTND** | Mută Jos |
| `btn[4]` | **BTNC** | Resetare Poziție |

## 📂 Structura Fișierelor

* `VGA_Shapes.vhd`: Fișierul Top-Level. Conține divizorul de ceas, contoarele H/V și logica de desenare.
* `ROM_Color.vhd`: Memorie ROM pentru decodificarea culorilor.
* `debouncer.vhd`: Modul pentru filtrarea semnalelor de la butoane.
* `constraints.xdc`: Fișier de constrângeri fizice pentru Nexys A7.

## 🚀 Utilizare

1.  Deschideți **Xilinx Vivado**.
2.  Creați un proiect nou pentru placa **Nexys A7**.
3.  Adăugați fișierele sursă (`.vhd`) și fișierul de constrângeri (`.xdc`).
4.  Rulați pașii: **Synthesis**, **Implementation** și **Generate Bitstream**.
5.  Programați placa prin USB.
6.  Conectați monitorul VGA la portul plăcii.

## 📜 Licență

Acest proiect a fost realizat în scop educațional în cadrul Facultății de Automatică și Calculatoare, UTCN.
