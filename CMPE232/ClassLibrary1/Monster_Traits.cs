namespace ClassLibrary1
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema; // <-- BU KÜTÜPHANE ŞART!

    public partial class Monster_Traits
    {
        public int ID { get; set; }

        // Veritabanındaki gerçek sütun isimleri (Alt çizgili)
        public int Monster_ID { get; set; }
        public int Trait_ID { get; set; }

        // 👇 ADRES TARİFLERİ (FOREIGN KEY) 👇

        [ForeignKey("Monster_ID")]
        public virtual Monster Monster { get; set; }

        [ForeignKey("Trait_ID")]
        public virtual Trait Trait { get; set; }
    }
}