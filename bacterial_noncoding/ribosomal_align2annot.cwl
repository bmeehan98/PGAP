cwlVersion: v1.2
label: "Generate rRNA Annotation"
class: CommandLineTool

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.asn_cache)
        writable: False
      - entry: $(inputs.blastdb_dir)
        writable: False
    
#ribosomal_align2annot -blastdb blastdb -asn-cache sequence_cache -filter-accept 'pct_identity_gap >= 70' -gap-tolerance 1000 -input-manifest aligns.mft -o annotations.asn -product-name '16S ribosomal RNA' -submission-mode-genbank
baseCommand: ribosomal_align2annot
arguments: [ -filter-accept, "pct_identity_gap >= 70", -gap-tolerance, "1000", -submission-mode-genbank, -nogenbank  ]
inputs:
  asn_cache:
    type: Directory
    inputBinding:
      prefix: -asn-cache
  blastdb_dir:
    type: Directory
  blastdb:
    type: string
    inputBinding:
      prefix: -blastdb
      valueFrom: $(inputs.blastdb_dir.path)/$(inputs.blastdb)
  product_name:
    type: string
    inputBinding:
      prefix: -product-name
  alignments:
    type: File
    inputBinding:
      prefix: -input
  annotation:
    type: string?
    default: annotations.asn
    inputBinding:
      prefix: -o
outputs:
  annotations:
    type: File
    outputBinding:
      glob: $(inputs.annotation)

  
  
