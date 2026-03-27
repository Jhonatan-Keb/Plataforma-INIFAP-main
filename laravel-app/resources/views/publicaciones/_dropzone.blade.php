@push('styles')
<style>
.drop-zone {
    border: 3px dashed #004d40;
    border-radius: 12px;
    padding: 30px;
    text-align: center;
    background-color: #f8f9fa;
    transition: all 0.2s ease-in-out;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.drop-zone:hover {
    border-color: #00897b;
    background-color: #e8f5e9;
}

.drop-zone.dragover {
    background-color: #e0f2f1;
    border-color: #00bfa5;
    border-style: solid;
    animation: pulse-dropzone 1.5s infinite;
    transform: scale(1.02);
    box-shadow: 0 0 20px rgba(0, 191, 165, 0.4);
}

@keyframes pulse-dropzone {
    0% { transform: scale(1.02); }
    50% { transform: scale(1.04); }
    100% { transform: scale(1.02); }
}

.drop-zone-text {
    font-weight: 500;
    color: #495057;
    margin-bottom: 0;
    pointer-events: none;
    transition: all 0.2s ease;
}

.drop-zone.dragover .drop-zone-text {
    color: #004d40;
    transform: scale(1.1);
}

.drop-zone-text i {
    font-size: 2.5rem;
    color: #004d40;
    margin-bottom: 12px;
    display: block;
    transition: transform 0.3s ease;
}

.drop-zone:hover .drop-zone-text i {
    transform: translateY(-5px);
}

.drop-zone.dragover .drop-zone-text i {
    transform: scale(1.2) translateY(-10px);
    color: #00bfa5;
}

.drop-zone-file-name {
    margin-top: 10px;
    color: #0d6efd;
    font-weight: bold;
    display: block;
    word-break: break-all;
    pointer-events: none;
}

.drop-zone input[type="file"] {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
    cursor: pointer;
    z-index: 10;
}
</style>
@endpush

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', function() {
    const dropZones = document.querySelectorAll('.drop-zone');

    dropZones.forEach(zone => {
        const input = zone.querySelector('input[type="file"]');
        const fileNameSpan = zone.querySelector('.drop-zone-file-name');
        
        // Prevent default drag behaviors
        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            zone.addEventListener(eventName, preventDefaults, false);
            document.body.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults(e) {
            e.preventDefault();
            e.stopPropagation();
        }

        // Highlight drop zone when item is dragged over it
        ['dragenter', 'dragover'].forEach(eventName => {
            zone.addEventListener(eventName, highlight, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            zone.addEventListener(eventName, unhighlight, false);
        });

        function highlight() {
            zone.classList.add('dragover');
        }

        function unhighlight() {
            zone.classList.remove('dragover');
        }

        // Handle dropped files
        zone.addEventListener('drop', handleDrop, false);

        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;

            if (files.length > 0) {
                // If the input doesn't have "multiple" attribute, we only take the first file
                if (!input.hasAttribute('multiple')) {
                    
                    // Create a new DataTransfer object to assign the file to the input
                    const dataTransfer = new DataTransfer();
                    dataTransfer.items.add(files[0]);
                    input.files = dataTransfer.files;
                    
                    // Force the change event to fire
                    input.dispatchEvent(new Event('change', { bubbles: true }));
                }
            }
        }
        
        // Handle normal file selection and update text
        input.addEventListener('change', function() {
            if (this.files && this.files.length > 0) {
                if (this.files.length === 1) {
                    fileNameSpan.textContent = this.files[0].name;
                } else {
                    fileNameSpan.textContent = this.files.length + ' archivos seleccionados';
                }
            } else {
                fileNameSpan.textContent = '';
            }
        });
    });
});
</script>
@endpush
