# Species scrubbing, only run once, but keeping in case of updates

anno <- readOGR("data/trimodal/trimodal_ann_aligned.shp", stringsAsFactors=FALSE)
sort(unique(anno$Species))

# Correcting annotations
anno$Species[anno$Species=="Acropora acuminata"] <- "Aacu"
anno$Species[anno$Species=="Acropora paniculata"] <- "Apan"
anno$Species[anno$Species=="Acyth"] <- "Acyt"
anno$Species[anno$Species=="AFdig"] <- "Afdig"
anno$Species[anno$Species=="Aflor"] <- "Aflo"
anno$Species[anno$Species=="Alut?"] <- "Alut"
anno$Species[anno$Species=="Astmyr"] <- "Astm"
anno$Species[anno$Species=="Averw"] <- "Aver"
anno$Species[anno$Species=="Ayong"] <- "Ayon"
anno$Species[anno$Species=="Cchal"] <- "Ccha"
anno$Species[anno$Species=="Echinophyllia orpheensis"] <- "Eorp"
anno$Species[anno$Species=="Ecinophyllia echinata"] <- "Eech"
anno$Species[anno$Species=="Favia danae"] <- "Fdan"
anno$Species[anno$Species=="Favia helianthoides"] <- "Fhel"
anno$Species[anno$Species=="Fcomp"] <- "Fcom"
anno$Species[anno$Species=="Fflex"] <- "Ffle"
anno$Species[anno$Species=="Fmat?"] <- "Fmat"
anno$Species[anno$Species=="Fpent"] <- "Fpen"
anno$Species[anno$Species=="Frotun"] <- "Frot"
anno$Species[anno$Species=="Fspec"] <- "Fspe"
anno$Species[anno$Species=="Goniastrea edwardsi"] <- "Gedw"
anno$Species[anno$Species=="Lmyce"] <- "Lmyc"
anno$Species[anno$Species=="Lpurr"] <- "Lpur"
anno$Species[anno$Species=="Ltrans"] <- "Ltra"
anno$Species[anno$Species=="Mannu"] <- "Mann"
anno$Species[anno$Species=="Mcras"] <- "Mcra"
anno$Species[anno$Species=="Mcrass"] <- "Mcra"
anno$Species[anno$Species=="Mgris"] <- "Mgri"
anno$Species[anno$Species=="Mincr"] <- "Minc"
anno$Species[anno$Species=="Mycedium elephantotus"] <- "Mele"
anno$Species[anno$Species=="Pachy"] <- "Pspe"
anno$Species[anno$Species=="Pachyseris speciosa"] <- "Pspe"
anno$Species[anno$Species=="Pspec"] <- "Pspe"
anno$Species[anno$Species=="Pavona minuta"] <- "Pmin"
anno$Species[anno$Species=="Pavona"] <- "Pmin"
anno$Species[anno$Species=="Pdae?"] <- "Pdae"
anno$Species[anno$Species=="Pectinia paeonia"] <- "Ppae"
anno$Species[anno$Species=="Physogyra lichtensteini"] <- "Plic"
anno$Species[anno$Species=="Pnier"] <- "Pnie"
anno$Species[anno$Species=="Porites cylindrica"] <- "Pcyl"
anno$Species[anno$Species=="Pprof"] <- "Ppro"
anno$Species[anno$Species=="Pspec"] <- "Pspe"
anno$Species[anno$Species=="Pvari"] <- "Pvar"
anno$Species[anno$Species=="Pverru"] <- "Pver"
anno$Species[anno$Species=="Sandalolitha robusta"] <- "Srob"
anno$Species[anno$Species=="Sarco"] <- "Sarc"
anno$Species[anno$Species=="Tubastrea spp"] <- "Tuba"
anno$Species[anno$Species=="Turbinaria frondens"] <- "Tfro"
anno$Species[anno$Species=="Turbinaria peltata"] <- "Tpel"

# Dropping annotations
anno <- anno[!is.na(anno@data$Species),]
anno <- anno[anno@data$Species != "Soft",]
anno <- anno[anno@data$Species!="Asp.",]
anno <- anno[anno@data$Species!="Cyphastrea sp.",]
anno <- anno[anno@data$Species!="Fire",]
anno <- anno[anno@data$Species!="P?",]

writeOGR(anno, "data/trimodal/", "trimodal_ann_aligned_cleaned", driver="ESRI Shapefile")
