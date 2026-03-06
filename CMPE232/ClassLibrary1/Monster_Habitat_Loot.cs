namespace ClassLibrary1
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema; // <-- Bu kütüphane ŞART!

    public partial class Monster_Habitat_Loot
    {
        public int ID { get; set; }

        // Veritabanındaki gerçek sütun isimleri
        public int Monster_ID { get; set; }
        public int Habitat_ID { get; set; }
        public int Loot_ID { get; set; }

        public Nullable<decimal> Drop_Rate { get; set; }

        // 👇 ADRES TARİFLERİ (FOREIGN KEY) 👇

        [ForeignKey("Habitat_ID")]
        public virtual Habitat Habitat { get; set; }

        [ForeignKey("Loot_ID")]
        public virtual Loot Loot { get; set; }

        [ForeignKey("Monster_ID")]
        public virtual Monster Monster { get; set; }
    }
}