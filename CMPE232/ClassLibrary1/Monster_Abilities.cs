namespace ClassLibrary1
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema; // <-- BU KÜTÜPHANE ŞART!

    public partial class Monster_Abilities
    {
        public int ID { get; set; }

        // Veritabanındaki gerçek sütun isimleri (Alt çizgili)
        public int Monster_ID { get; set; }
        public int Ability_ID { get; set; }

        // 👇 ADRES TARİFLERİ (FOREIGN KEY) 👇
        // Sisteme diyoruz ki: "Ability tablosuna giderken Ability_ID sütununu kullan!"

        [ForeignKey("Ability_ID")]
        public virtual Ability Ability { get; set; }

        [ForeignKey("Monster_ID")]
        public virtual Monster Monster { get; set; }
    }
}