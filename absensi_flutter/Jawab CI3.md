## Pertanyaan

### 1. Analisis Arsitektur (50 poin)
#### Jelaskan dengan detail bagaimana flow kerja dari kode di atas:
#### Jawaban:
Codeigniter menggunakan model MVC dimana hal-hal yang berkaitan dengan database diatur menggunakan model.Sedangkan untuk controller sendiri sebagai penghubung model dan view,dimana permintaan user diolah di customer kemudian ditampilkan menggunakan view. Sedangkan view sendiri adalah antarmuka pengguna yang berisi html yang menampilkan olahan data dari controller.

##### MVC:
Daftar Controller:`Brand`
Daftar Model: `Brand_model`
Daftar View: `index.php`, `list.php`,dan `create.php`

Semua mvc tersebut ada di modul `product` dengan `Brand` sebagai sub nya.

Controller dan Model adalah extend dari custom base model dan controller jadi bukan bawaan dari CI nya sendiri.

##### Alur Kerja:

###### Akan mengarahkan `index()` → Saat akses `/product/brand`
Load CSS dan JS datatable
Load model `Brand_model`
Kemudian diarahkan ke view `index` di `application/views/product/Brand/index.php`


###### Akan mengarahkan `read()` → Saat akses `/product/brand/read/{$a}`
- Jika:
$a == 'list'
    Akan menyiapkan konfigurasi kolom DataTables.

    Mengembalikan HTML partial (biasanya view tabel).

    Ini berguna untuk menampilkan tabel dinamis via AJAX.

    Data-nya akan diambil dari endpoint berikutnya:
    /product/brand/read/json_list

$a == 'json'
    Akan menampilkan data brand dalam format JSON mentah.

    Data diambil dari method read($p) di model.

    Umumnya digunakan untuk kebutuhan frontend yang memerlukan JSON sederhana.

$a == 'array'
    Mengembalikan data dari model dalam bentuk array PHP (bukan JSON atau HTML).
$a == 'json_list'
    Melakukan query dengan filter (jika ada) dari $_POST (misalnya brand_name).

    Hasilnya akan dikembalikan dalam bentuk JSON khusus untuk DataTables (server-side processing).

    Format hasilnya lengkap: draw, recordsTotal, recordsFiltered, data, dll.
Lainnya
    redirect ke index()

###### Akan mengarahkan `create()` → Saat akses `/product/brand/create`
View `create.php` dimuat dan tampil form.
Submit → fInput kirim data via AJAX ke backend.


### 2. Pertanyaan Teoritis (50 poin)

#### Mengapa controller `Brand` extends `My_Controller`?
- `My_Controller` adalah custom base controller yang menyediakan:
  - `add_style()`, `add_script()`, `set()`, `render()`
  - Inisialisasi properti `$this->name`, `$this->directory`
- Membuat controller lebih modular, konsisten, dan hemat penulisan kode.

---

#### Mengapa `Brand_model` hanya berisi konfigurasi minimal?
- Karena semua logika CRUD sudah disediakan oleh `MY_Model`.
- Model cukup mendeklarasikan:
  - `protected $tableName`
  - `public $primaryKey`
  - `selectFields`, `joinFields`, dsb
- Method seperti `read()`, `create()`, `delete()` diturunkan dari `MY_Model`.

####  Keuntungan Arsitektur ini
#####  Kelebihan:
1. DRY (Don't Repeat Yourself)
2. Modular dan konsisten
3. Mudah dikembangkan (scalable)
4. Mudah dipelihara (maintenance-friendly)

#####  Kekurangan:
1. Developer baru harus memahami base class terlebih dahulu
2. Debugging bisa lebih sulit

---

####  Apakah Bersedia Mengembangkan Arsitektur Ini?
Ya, saya bersedia. Karena saya memahami strukturnya dan terbiasa bekerja dengan pendekatan OOP, inheritance, dan abstraction.