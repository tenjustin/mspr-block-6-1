using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace plant_app_backend.Models;

[Table("User")]
public partial class User
{
    [Key]
    public int Id { get; set; }

    [Required]
    public string Nom { get; set; }

    [Required]
    public string Prenom { get; set; }

    [Required]
    public string Pseudo { get; set; }

    [Required]
    public string Password { get; set; }

    [Required]
    public string Email { get; set; }

    [Required]
    public string Sexe { get; set; }

    public DateOnly DateDeNaissance { get; set; }

    public int IsBotanist { get; set; }

    [InverseProperty("User")]
    public virtual ICollection<Annonce> Annonces { get; set; } = new List<Annonce>();
}
