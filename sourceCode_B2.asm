; Vending Machine
;Port 0 digunakan untuk menampilkan LED 7-segment sebagai outputnya
;Port 1 digunakan untuk matrix keypad sebagai inputnya
;Port 2 digunakan sebagai motor penggerak vending machine
;Cara menggunakan program :
;1. Menekan salah satu tombol huruf A-D pada keypad sebagai input untuk mengidentifikasi sudah membayar
;2. Menekan salah satu tombol nomor 0-9 pada keypad sebagai input untuk memilih produk
;3. Setelah 7-segment memunculkan angka output maka program akan berakhir

DATA_PTR equ 200h ; directive value 

org 0h
AJMP START

START:					; MAIN Program (Memulai Program)
	CLR A	
	SETB P1.7
 	SETB P1.0
 	SETB P1.1
 	SETB P1.2
 	SETB P1.3 		
	CLR P1.7
	JNB P1.0, BAYAR			;Fungsi akan jump ke BAYAR jika keypad P2.0 dipilih
	JNB P1.1, BAYAR			;Fungsi akan jump ke BAYAR jika keypad P2.1 dipilih
	JNB P1.2, BAYAR			;Fungsi akan jump ke BAYAR jika keypad P2.2 dipilih
	JNB P1.3, BAYAR			;Fungsi akan jump ke BAYAR jika keypad P2.3 dipilih
	JB P1.0, START			;Fungsi akan kembali ke START jika P2.0 (keypad tidak dipilih)

BAYAR: 					; Program untuk mengidentifikasi pembayaran
	MOV DPTR, #200h			
	CLR A
	
LOOP:					; LOOP untuk mengidentifikasi bahwa sudah membayar
	MOV R1, A
	MOV A, P0
	MOV P2, #00000000b		;Mereset motor vending machine
	CJNE A, #10000011b, PANGGIL	;Fungsi akan jump ke PANGGIL jika bit tidak bernilai #11000000b
	AJMP PILIH1			;Fungsi akan jump ke PILIH1
	
PANGGIL:				;Fungsi panggil agar dapat mengakses data pada ROM 
	MOV A, R1
	MOVC A, @A+DPTR			;;indexed addressing	;Fungsi untuk mengakses data pada ROM 
	MOV P0, A
	MOV A, R1			;;Register addressing
	INC A				;Melakukan Increment pada register A			
	AJMP LOOP			;Fungsi akan jump ke LOOP

PILIH1: 				;Program untuk memilih produk dari baris ke-1
	CLR A
	SETB PSW.4			
	SETB PSW.3			;Fungsi untuk menge-set data pada register bank 3
	MOV P1, #11111111b
	CLR P1.0			
	JNB P1.4, SATU			;Fungsi akan jump ke SATU jika keypad P2.4 dipilih (no.1)
	JNB P1.5, DUA			;Fungsi akan jump ke DUA jika keypad P2.5 dipiklih (no.2)
	JNB P1.6, TIGA			;Fungsi akan jump ke TIGA jika keypad P2.6 dipilih (no.3)
	AJMP PILIH2			;Fungsi akan jump ke PILIH2
		
SATU: 					;Fungsi untuk menampilkan angka 1 pada 7-segment sebagai output
	MOV P0, #0F9H
	MOV P2, #00000001B		;Untuk menggerekan motor produk-1
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program

DUA:					;Fungsi untuk menampilkan angka 2 pada 7-segment sebagai output
	MOV P0, #10100100b
	MOV P2, #00000010B		;Untuk menggerekan motor produk-2
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program

TIGA: 					;Fungsi untuk menampilkan angka 3 pada 7-segment sebagai output
	MOV A, #01001111b
	CPL A
	MOV P0, A
	MOV P2, #00000011B		;Untuk menggerekan motor produk-3
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program

PILIH2:					;Program untuk memilih produk dari baris ke-2
	CLR A
	SETB P1.0
	CLR P1.1
	JNB P1.4, EMPAT			;Fungsi akan jump ke EMPAT jika keypad P2.4 dipilih (no.4)
	JNB P1.5, LIMA			;Fungsi akan jump ke LIMA jika keypad P2.5 dipilih (no.5)
	JNB P1.6, ENAM			;Fungsi akan jump ke ENAM jika keypad P2.6 dipilih (no.6)
	AJMP PILIH3			;Fungsi akan jump ke PILIH3
	
EMPAT:					;Fungsi untuk menampilkan angka 4 pada 7-segment sebagai output
	MOV A, #99H
	MOV P0, A
	MOV P2, #00000100B		;Untuk menggerekan motor produk-4
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program

LIMA:					;Fungsi untuk menampilkan angka 5 pada 7-segment sebagai output
	MOV A, #92H
	MOV P0, A
	MOV P2, #00000101B		;;Untuk menggerekan motor produk-5
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program

ENAM:					;Fungsi untuk menampilkan angka 6 pada 7-segment sebagai output
	MOV A, #41H
	MOV B, #2H
	MUL AB
	MOV P0, A
	MOV P2, #00000110B		;Untuk menggerekan motor produk-6
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program
	
PILIH3:					;Program untuk memilih produk dari baris ke-3
	CLR A
	SETB P1.1
	CLR P1.2
	JNB P1.4, TUJUH			;Fungsi akan jump ke TUJUH jika keypad P2.4 dipilih (no.7)
	JNB P1.5, DELAPAN		;Fungsi akan jump ke DELAPAN jika keypad P2.5 dipilih (no.8)
	JNB P1.6, SEMBILAN		;Fungsi akan jump ke SEMBILAN jika keypad P2.6 dipilih (no.9)
	AJMP PILIH1			;Fungsi akan jump ke PILIH1
	
TUJUH:					;Fungsi untuk menampilkan angka 7 pada 7-segment sebagai output
	MOV P0, #11111000b
	MOV P2, #00000111B		;Untuk menggerekan motor produk-7
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program

DELAPAN: 				;Fungsi untuk menampilkan angka 8 pada 7-segment sebagai output
	MOV A, #40H
	MOV B, #40H
	ADD A,B
	DA A
	MOV P0, A
	MOV P2, #00001000B		;Untuk menggerekan motor produk-8
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program

SEMBILAN:				;Fungsi untuk menampilkan angka 9 pada 7-segment sebagai output
	MOV P0, #90H
	MOV P2, #00001001B		;Untuk menggerekan motor produk-9
	ACALL DELAY			;Memanggil fungsi DELAY
	ACALL ENDING			;Memanggil fungsi ENDING untuk mengakhiri program
	
org 200h				;ROM yang diakses pada alamat 200h
DATA1: DB 0F9H, 131			;isi data pada room = 1 dan b

DELAY: 	MOV 20H, #30H			;Fungsi DELAY (Memberikan nilai countdown)
	MOV R0, 20H			;;direct addressing
	MOV A, @R0			;;register indirect addressing
STAY: 	DJNZ R0, STAY			;Fungsi STAY (Countdown dari Delay)
	RET
	
ENDING:
JMP START
END				
