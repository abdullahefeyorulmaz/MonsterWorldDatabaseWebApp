namespace ClassLibrary1
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema; // <-- ŞART!

    public partial class Monster_Weaknesses
    {
        public int ID { get; set; }

        // Veritabanındaki gerçek sütun isimleri
        public int Monster_ID { get; set; }
        public int DamageType_ID { get; set; }

        // 👇 ADRES TARİFLERİ (FOREIGN KEY) 👇

        [ForeignKey("Monster_ID")]
        public virtual Monster Monster { get; set; }

        [ForeignKey("DamageType_ID")]
        public virtual Damage_Type Damage_Type { get; set; }
    }
}