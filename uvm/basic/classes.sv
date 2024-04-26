class rectangle_t;
    // Data members:
    int length;
    int width;

    // Constructor:
    function new(int len, int wid);
        length = len;
        width = wid;
    endfunction

    // Method:
    function integer perimeter;
        return (length * 2) + (width * 2);
    endfunction
endclass

class square_t extends rectangle_t;
    function new(int len);
        super.new(len, len) // Call parent constructor
    endfunction
endclass

module class_module;
    rectangle_t rectangle;  // Create pointer to object
    initial begin
        rectangle = new(10, 20);    // Actually instantiate the object
        $display(rectangle.perimeter);  // Call perimeter() method
        square = new(5);
        $display(square.perimeter);
endmodule